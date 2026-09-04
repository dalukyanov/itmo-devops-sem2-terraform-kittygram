# Создание облачной сети
resource "yandex_vpc_network" "kittygram_network" {
  name = "kittygram-network"
}

# Создание подсети
resource "yandex_vpc_subnet" "kittygram_subnet" {
  name           = "kittygram-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.kittygram_network.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

# Группа безопасности
resource "yandex_vpc_security_group" "kittygram_sg" {
  name        = "kittygram-security-group"
  description = "Security group for Kittygram VM"
  network_id  = yandex_vpc_network.kittygram_network.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP (Kittygram gateway)"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 9000
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Бакет для Terraform state
resource "yandex_storage_bucket" "tfstate" {
  bucket = var.tfstate_bucket_name
  acl    = "private"
}

# Бакет для статики приложения
resource "yandex_storage_bucket" "kittygram" {
  bucket     = var.app_bucket_name
  depends_on = [yandex_storage_bucket.tfstate]

  # Настройка прав доступа для бакета
  grant {
    id          = var.yc_service_account_id
    type        = "CanonicalUser"
    permissions = ["READ", "WRITE"]
  }
}

# Создание виртуальной машины
resource "yandex_compute_instance" "kittygram" {
  name        = var.vm_name
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd80bu10m2sevk4n1tgb" # Ubuntu 22.04 LTS
      size     = 30
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram_subnet.id
    security_group_ids = [yandex_vpc_security_group.kittygram_sg.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "${var.vm_user}:${file(var.ssh_public_key)}"
    user-data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
      username       = var.vm_user
      ssh_public_key = file(var.ssh_public_key)
    })
  }

  scheduling_policy {
    preemptible = true
  }
}