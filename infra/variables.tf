# Подключение будет через сервисный аккаунт из-за изменений в политике Yandex Cloud в июле 2026
#variable "yc_token" {
#  type      = string
#  sensitive = true
#}

variable "yc_cloud_id" {
  type = string
}

variable "yc_folder_id" {
  type = string
}

variable "yc_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "storage_access_key" {
  type      = string
  sensitive = true
}

variable "storage_secret_key" {
  type      = string
  sensitive = true
}

variable "vm_name" {
  type    = string
  default = "kittygram-vm"
}

variable "vm_user" {
  type    = string
  default = "ubuntu"
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}

variable "gateway_port" {
  type    = number
  default = 9000
}

variable "ssh_allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "service_allowed_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "image_family" {
  type    = string
  default = "ubuntu-2404-lts"
}

variable "app_bucket_name" {
  type = string
}

# Данные key.json будут переданы в виде GitHub Secret
variable "yc_service_account_key_file" {
  description = "Path to service account key file"
  type        = string
  default     = "/tmp/key.json"
}