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

module "api_and_service" {
  source = "../modules/api_and_service"
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
  service_compute   = module.api_and_service.service_compute
  service_container = module.api_and_service.service_container
  service_admin_api = module.api_and_service.service_admin_api
}

module "k8s" {
  source = "../modules/k8s"

  cluster_name          = var.cluster_name
  pod_secondary_ip      = var.pod_secondary_ip
  services_secondary_ip = var.services_secondary_ip
  machine_type          = var.machine_type
  max_node_count        = var.max_node_count

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

module "network_service" {
  source   = "../modules/network_service"
  nat_name = var.nat_name

  # From module putput
  subnetwork      = module.vpc.subnetwork
  network         = module.vpc.network
  router_name     = var.router_name
  service_network = module.api_and_service.service_network

  # General variable
  project_id       = var.project_id
  application_code = var.application_code
  environment      = var.environment
  organization     = var.organization
  region           = var.region
}

module "cloudsql" {
  source             = "../modules/cloudsql"
  password_db        = var.password_db
  sa_proxy_cloud_sql = var.sa_proxy_cloud_sql
  count              = var.cloud_sql_enabled ? 1 : 0


  # From module putput
  network                = module.vpc.network
  service_networking_api = module.api_and_service.service_networking_api

  # General variable
  project_id       = var.project_id
  application_code = var.application_code
  environment      = var.environment
  organization     = var.organization
  region           = var.region
}