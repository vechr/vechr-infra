output "ip_address" {
  description = "IP Addresses"
  value = "Name: ${google_compute_address.ip_address.name} IP: ${google_compute_address.ip_address.address}"
}