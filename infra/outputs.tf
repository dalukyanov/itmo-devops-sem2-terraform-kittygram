output "kittygram_url" {
  description = "Kittygram URL to connect"
  value       = "http://${yandex_compute_instance.kittygram.network_interface[0].nat_ip_address}:${var.gateway_port}"
}

output "external_ip" {
  description = "External Kittygram VM IP"
  value       = yandex_compute_instance.kittygram.network_interface[0].nat_ip_address
}

# output "app_bucket_name" {
#   value = yandex_storage_bucket.kittygram.bucket
# }