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