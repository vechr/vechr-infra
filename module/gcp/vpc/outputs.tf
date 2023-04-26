output "network" {
  description = "Network default"
  value       = google_compute_network.default.self_link
}

output "subnetwork" {
  description = "Subnetwork default"
  value       = google_compute_subnetwork.default.self_link
}