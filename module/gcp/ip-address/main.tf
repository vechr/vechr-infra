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

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
resource "google_compute_address" "ip_address" {
  name = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-${var.ip_address.name}"
  project = var.project_id
  address_type = var.ip_address.address_type
  region = var.region
}