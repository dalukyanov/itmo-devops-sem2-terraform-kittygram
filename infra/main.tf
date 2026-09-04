data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "yandex_vpc_network" "kittygram" {
  name = "kittygram-network"
}

resource "yandex_vpc_subnet" "kittygram" {
  name           = "kittygram-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.kittygram.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

resource "yandex_vpc_security_group" "kittygram" {
  name        = "kittygram-sg"
  description = "Allow SSH and Kittygram gateway only connections"
  network_id  = yandex_vpc_network.kittygram.id

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = var.ssh_allowed_cidrs
  }

  ingress {
    description    = "Kittygram gateway HTTP"
    protocol       = "TCP"
    port           = var.gateway_port
    v4_cidr_blocks = var.service_allowed_cidrs
  }

  egress {
    description    = "Allow all outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "kittygram" {
  name                      = var.vm_name
  hostname                  = var.vm_name
  zone                      = var.yc_zone
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  
  # Minimal resources
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.kittygram.id]
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
      username       = var.vm_user
      ssh_public_key = var.ssh_public_key
    })
  }
}

resource "yandex_storage_bucket" "kittygram" {
  bucket        = var.app_bucket_name
  folder_id     = var.yc_folder_id
  acl           = "private"
  force_destroy = true
}