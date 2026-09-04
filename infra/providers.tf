# Подключение будет через сервисный аккаунт из-за изменений в политике Yandex Cloud в июле 2026
provider "yandex" {
  service_account_key_file = var.yc_service_account_key_file
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_zone
}