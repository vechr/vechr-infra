output "network" {
  description = "Network default"
  value       = google_compute_network.default
}

output "subnetwork" {
  description = "Subnetwork default"
  value       = google_compute_subnetwork.default
}