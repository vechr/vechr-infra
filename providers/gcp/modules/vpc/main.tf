# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
# VPC
resource "google_compute_network" "main_vpc" {
  name                            = "${var.organization}-${var.application_code}-${var.environment}-${var.network_name}"
  description                     = "VPC for Kubernetes IIOT (${var.environment})"
  routing_mode                    = var.routing_mode
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = true

  depends_on = [
    var.service_compute,
    var.service_container
  ]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# Subnet
resource "google_compute_subnetwork" "private" {
  name                     = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-${var.subnet_private.name}"
  ip_cidr_range            = var.subnet_private.ip_cidr_range
  region                   = var.region
  network                  = google_compute_network.main_vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = var.pod_secondary_ip.range_name
    ip_cidr_range = var.pod_secondary_ip.ip_cidr_range
  }

  secondary_ip_range {
    range_name    = var.services_secondary_ip.range_name
    ip_cidr_range = var.services_secondary_ip.ip_cidr_range
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
# Firewall
# We don't need to create any firewalls manually for GKE; it's just to give you an example. This firewall will allow sshing to the compute instances within VPC.
resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.organization}-${var.application_code}-22-${var.firewall_ssh_name}"
  network = google_compute_network.main_vpc.name

  allow {
    protocol = var.firewall_ssh.protocol
    ports    = var.firewall_ssh.ports
  }

  source_ranges = var.firewall_source_range
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route
resource "google_compute_route" "internet_gateway_route" {
  name             = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-internet-gateway"
  description      = "Default route to the Internet."
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.main_vpc.name
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}