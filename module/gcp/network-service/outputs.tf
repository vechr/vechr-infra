output "nat" {
  description = "nat name"
  value = google_compute_router_nat.default.name
}

output "router" {
  description = "router name"
  value = google_compute_router.default.name
}