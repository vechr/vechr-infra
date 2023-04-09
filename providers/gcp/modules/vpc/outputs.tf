output "network" {
  description = "network self link"
  value       = google_compute_network.main_vpc
}

output "subnetwork" {
  description = "subnetwork self link"
  value       = google_compute_subnetwork.private
}