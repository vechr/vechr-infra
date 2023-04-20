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

resource "google_compute_global_address" "global_ip_address" {
  name = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-${var.global_ip_address.name}"
  project = var.project_id
  address_type = var.global_ip_address.address_type
}