terraform {
  backend "gcs" {}

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.61.0"
    }
  }
}

provider "google" {
  # Configuration options
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = var.credentials
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
# VPC
resource "google_compute_network" "default" {
  name                            = "${var.organization}-${var.application_code}-${var.environment}-${var.network_name}"
  description                     = "VPC for Kubernetes IIOT (${var.environment})"
  routing_mode                    = var.routing_mode
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = true
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# Subnet
resource "google_compute_subnetwork" "default" {
  name                     = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-${var.subnet.name}"
  ip_cidr_range            = var.subnet.ip_cidr_range
  region                   = var.region
  network                  = google_compute_network.default.id
  private_ip_google_access = var.subnet.private_ip_google_access

  count                    = length(var.subnet.secondary_ip_ranges)
  secondary_ip_range {
    range_name    = var.subnet.secondary_ip_ranges[count.index].range_name
    ip_cidr_range = var.subnet.secondary_ip_ranges[count.index].ip_cidr_range
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
# Firewall
# We don't need to create any firewalls manually for GKE; it's just to give you an example. This firewall will allow sshing to the compute instances within VPC.
resource "google_compute_firewall" "default" {
  name    = "${var.organization}-${var.application_code}-${var.firewall.name}"
  network = google_compute_network.default.name

  allow {
    protocol = var.firewall.allow.protocol
    ports    = var.firewall.allow.ports
  }

  source_ranges = var.firewall.source_ranges
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route
resource "google_compute_route" "internet_gateway_route" {
  name             = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-internet-gateway"
  description      = "Default route to the Internet."
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.default.name
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}