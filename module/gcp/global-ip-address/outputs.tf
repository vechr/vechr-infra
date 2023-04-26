output "global_ip_address" {
  description = "Global IP Addresses"
  value = "Name: ${google_compute_global_address.global_ip_address.name} IP: ${google_compute_global_address.global_ip_address.address}"
}