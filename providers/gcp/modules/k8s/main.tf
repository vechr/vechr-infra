# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# Cluster
resource "google_container_cluster" "primary" {
  name                     = "${var.organization}-${var.application_code}-${var.environment}-${var.cluster_name}"
  location                 = "${var.region}-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network.self_link
  subnetwork               = var.subnetwork.self_link
  networking_mode          = "VPC_NATIVE"

  # Optional, if you want multi-zonal cluster
  # node_locations = [
  #   "${var.region}-b"
  # ]

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = true
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
    cluster_secondary_range_name  = var.pod_secondary_ip.range_name
    services_secondary_range_name = var.services_secondary_ip.range_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "general" {
  name     = "${var.organization}-${var.application_code}-${var.environment}-general-node-pool"
  cluster  = google_container_cluster.primary.name
  project  = var.project_id
  location = "${var.region}-a"

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type

    labels = {
      role = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
