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

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# Cluster
resource "google_container_cluster" "default" {
  name                     = "${var.organization}-${var.application_code}-${var.environment}-${var.cluster.name}"
  location                 = "${var.region}-a"
  remove_default_node_pool = var.cluster.remove_default_node_pool
  initial_node_count       = var.cluster.initial_node_count
  network                  = var.network
  subnetwork               = var.subnetwork
  networking_mode          = "VPC_NATIVE"

  # Optional, if you want multi-zonal cluster
  # node_locations = [
  #   "${var.region}-b"
  # ]

  addons_config {
    http_load_balancing {
      disabled = var.cluster.disabled_load_balancing
    }
    horizontal_pod_autoscaling {
      disabled = var.cluster.disabled_horizontal_pod_autoscaling
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  network_policy {
    provider = "PROVIDER_UNSPECIFIED"
    enabled  = true
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster.pod_secondary_range_name
    services_secondary_range_name = var.cluster.services_secondary_range_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "default" {
  name     = "${var.organization}-${var.application_code}-${var.environment}-${var.node_pool.name}"
  cluster  = google_container_cluster.default.name
  project  = var.project_id
  location = "${var.region}-a"

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = var.node_pool.max_node_count
  }

  node_config {
    preemptible  = var.node_pool.preemptible
    machine_type = var.node_pool.machine_type
    disk_size_gb = var.node_pool.disk_size_gb
    disk_type = var.node_pool.disk_type

    labels = {
      role = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
