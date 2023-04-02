output "network" {
  description = "network self link"
  value       = google_compute_network.main_vpc
}

output "subnetwork" {
  description = "subnetwork self link"
  value       = google_compute_subnetwork.private
}

output "sql_private_vpc_connection" {
  description = "Private VPC connection for SQL"
  value       = google_service_networking_connection.private_vpc_sql_connection
}