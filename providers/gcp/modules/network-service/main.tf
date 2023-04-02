# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
# Cloud NAT
resource "google_compute_router_nat" "nat" {
  name    = "${var.organization}-${var.application_code}-${var.environment}-${var.nat_name}"
  router  = google_compute_router.router.name # Important!
  region  = var.region
  project = var.project_id

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"

  depends_on = [
    var.subnetwork,
    google_compute_router.router
  ]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
# Router
# NAT gateway to allow VMs without public IP addresses to access the internet. For example, Kubernetes nodes will be able to pull docker images from the docker hub.
resource "google_compute_router" "router" {
  name    = "${var.organization}-${var.application_code}-${var.environment}-${var.router_name}"
  region  = var.region
  project = var.project_id
  network = var.network.self_link
}