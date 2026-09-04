output "kittygram_url" {
  description = "Kittygram URL to connect"
  value       = "http://${yandex_compute_instance.kittygram.network_interface[0].nat_ip_address}:9000"
}

output "external_ip" {
  description = "External Kittygram VM IP"
  value       = yandex_compute_instance.kittygram.network_interface[0].nat_ip_address
}

output "app_bucket_name" {
  description = "S3 bucket name for static files"
  value       = yandex_storage_bucket.kittygram.bucket
}