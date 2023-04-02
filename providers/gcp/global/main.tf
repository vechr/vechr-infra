# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = var.google_credentials
}

# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {}

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.66"
    }
  }
}

module "api-and-service" {
  source = "../modules/api-&-service"
}


module "vpc" {
  source = "../modules/vpc"

  network_name          = var.network_name
  routing_mode          = var.routing_mode
  subnet_private        = var.subnet_private
  pod_secondary_ip      = var.pod_secondary_ip
  services_secondary_ip = var.services_secondary_ip
  firewall_ssh          = var.firewall_ssh
  firewall_ssh_name     = var.firewall_ssh_name
  firewall_source_range = var.firewall_source_range

  # General variable
  project_id       = var.project_id
  application_code = var.application_code
  environment      = var.environment
  organization     = var.organization
  region           = var.region

  # From module putput
  service_compute        = module.api-and-service.service_compute
  service_container      = module.api-and-service.service_container
  service_admin_api      = module.api-and-service.service_admin_api
  service_networking_api = module.api-and-service.service_networking_api
}

module "k8s" {
  source = "../modules/k8s"

  cluster_name          = var.cluster_name
  pod_secondary_ip      = var.pod_secondary_ip
  services_secondary_ip = var.services_secondary_ip

  # From module putput
  network    = module.vpc.network
  subnetwork = module.vpc.subnetwork

  # General variable
  project_id       = var.project_id
  application_code = var.application_code
  environment      = var.environment
  organization     = var.organization
  region           = var.region
}

module "network-service" {
  source   = "../modules/network-service"
  nat_name = var.nat_name

  # From module putput
  subnetwork  = module.vpc.subnetwork
  network     = module.vpc.network
  router_name = var.router_name

  # General variable
  project_id       = var.project_id
  application_code = var.application_code
  environment      = var.environment
  organization     = var.organization
  region           = var.region
}