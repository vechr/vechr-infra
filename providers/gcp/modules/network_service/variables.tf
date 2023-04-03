variable "nat_name" {
  description = "Name of your NAT"
}
variable "network" {
  description = "network self link"
}
variable "subnetwork" {
  description = "subnetwork self link"
}

variable "router_name" {
  description = "router name"
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

variable "service_network" {
  description = "Enable the Service Network"
}