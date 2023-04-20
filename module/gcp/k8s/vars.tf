# Main
variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region of the Project"
}

variable "environment" {
  type        = string
  description = "Environment Stage"
}

variable "organization" {
  type        = string
  description = "Organization of App"
}

variable "application_code" {
  type        = string
  description = "Application of Code"
}

variable "zone" {
  type = string
  description = "Zone of Module"
}

variable "credentials" {
  type = string
  description = "Credentials for Providers"
}

# k8s
variable "cluster" {
  type = object({
    name: string
    remove_default_node_pool: bool
    initial_node_count: number
    disabled_load_balancing: bool
    disabled_horizontal_pod_autoscaling: bool
    pod_secondary_range_name: string
    services_secondary_range_name: string
  })
}

variable "node_pool" {
  type = object({
    name: string
    machine_type: string
    preemptible: bool
    disk_size_gb: number
    disk_type: string
    max_node_count: number
  })

  default = {
    name = "general-node-pool"
    disk_size_gb = 20
    disk_type = "pd-standard"
    machine_type = "e2-highcpu-8"
    preemptible = false
    max_node_count = 20
  }
}

variable "network" {
  description = "network self link"
}

variable "subnetwork" {
  description = "subnetwork self link"
}