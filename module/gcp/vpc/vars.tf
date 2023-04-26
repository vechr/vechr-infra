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

# VPC
variable "network_name" {
  description = "Name for your network"
  type        = string
}

variable "routing_mode" {
  description = "Routing Mode of VPC"
  type        = string
}

variable "subnet" {
  description = "Subnet of default VPC"
  type = object({
    name: string
    ip_cidr_range: string
    private_ip_google_access: bool
    pod_secondary_ip: object({
      range_name: string
      ip_cidr_range: string
    })
    services_secondary_ip: object({
      range_name: string
      ip_cidr_range: string
    })
  })
}

variable "firewall" {
  description = "Firewall that attach to default VPC"
  type = object({
    name: string
    allow: object({
      protocol: string
      ports: list(string)
    })
    source_ranges: list(string)
  })
}