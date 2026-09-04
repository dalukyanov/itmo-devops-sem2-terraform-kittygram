variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  sensitive   = true
  default     = null
}

variable "yc_service_account_key_file" {
  description = "Path to Yandex Cloud service account key file"
  sensitive   = true
}

variable "yc_service_account_id" {
  description = "Yandex Cloud Service Account ID"
  type        = string
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "yc_zone" {
  description = "Yandex Cloud Zone"
  type        = string
  default     = "ru-central1-a"
}

variable "tfstate_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "app_bucket_name" {
  description = "S3 bucket name for application static files"
  type        = string
}

variable "vm_name" {
  description = "VM name"
  type        = string
  default     = "kittygram-vm"
}

variable "vm_user" {
  description = "VM username for SSH"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "storage_access_key" {
  description = "Yandex Cloud Storage access key"
  type        = string
  sensitive   = true
}

variable "storage_secret_key" {
  description = "Yandex Cloud Storage secret key"
  type        = string
  sensitive   = true
}