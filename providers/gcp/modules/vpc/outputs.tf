output "network" {
  description = "network self link"
  value       = google_compute_network.main_vpc
}

output "subnetwork" {
  description = "subnetwork self link"
  value       = google_compute_subnetwork.private
}

output "nats_ip" {
  description = "nats ip global"
  value = "Name: ${google_compute_address.nats_ip.name} IP: ${google_compute_address.nats_ip.address}"
}

output "ingress_ip" {
  description = "nats ip global"
  value = "Name: ${google_compute_global_address.ingress_ip.name} IP: ${google_compute_global_address.ingress_ip.address}"
}