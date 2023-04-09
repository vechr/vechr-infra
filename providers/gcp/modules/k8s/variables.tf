variable "cluster_name" {
  description = "Name of Cluster Kubernetes"
}

variable "network" {
  description = "network self link"
}

variable "subnetwork" {
  description = "subnetwork self link"
}

variable "pod_secondary_ip" {
  description = "Secondary ip range for Pod"
  type = object({
    range_name : string
    ip_cidr_range : string
  })
}

variable "services_secondary_ip" {
  description = "Secondary ip range for Service"
  type = object({
    range_name : string
    ip_cidr_range : string
  })
}

variable "node_pool" {
  type = object({
    machine_type: string
    preemptible: bool
    disk_size_gb: number
    disk_type: string
    max_node_count: number
  })

  default = {
    disk_size_gb = 20
    disk_type = "pd-standard"
    machine_type = "e2-highcpu-8"
    preemptible = false
    max_node_count = 20
  }
}

# Main
variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region of the Project"
  default     = "asia-southeast2"
}

variable "environment" {
  type        = string
  description = "Environment Stage"
  default     = "dev"
}

variable "organization" {
  type        = string
  description = "Organization of App"
}

variable "application_code" {
  type        = string
  description = "Application of Code"
}