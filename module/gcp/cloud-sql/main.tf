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

################################################### Database Instance for Cloud SQL ###################################################
resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  name                = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-private-instance-${random_id.db_name_suffix.hex}"
  region              = var.region
  database_version    = "POSTGRES_14"
  deletion_protection = false
  depends_on          = [google_service_networking_connection.private_vpc_sql_connection]

  settings {
    tier              = "db-f1-micro"
    disk_type         = "PD_SSD"
    disk_size         = 10
    availability_type = "ZONAL"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network.id
    }
  }
}

resource "google_sql_user" "users" {
  name     = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-user"
  instance = google_sql_database_instance.instance.name
  password = var.password_db
}

################################################### Private IP Address for Cloud SQL ###################################################
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
resource "google_compute_global_address" "private_sql_ip_address" {
  name          = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network.id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection
resource "google_service_networking_connection" "private_vpc_sql_connection" {
  network                 = var.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_sql_ip_address.name]
}

################################################### Service Account for Cloud SQL ###################################################
resource "google_service_account" "proxy_account" {
  account_id = var.sa_proxy_cloud_sql
  project    = var.project_id
}
resource "google_project_iam_member" "role" {
  project = var.project_id
  role    = "roles/cloudsql.editor"
  member  = "serviceAccount:${google_service_account.proxy_account.email}"
}
resource "google_service_account_key" "key" {
  service_account_id = google_service_account.proxy_account.name
}