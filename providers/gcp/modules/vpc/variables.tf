variable "network_name" {
  description = "Name for your network"
  type        = string
}

variable "routing_mode" {
  description = "Routing Mode of VPC"
  type        = string
}

variable "subnet_private" {
  description = "Variable of your Subnet Private"
  type = object({
    name : string
    ip_cidr_range : string
  })
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
variable "firewall_ssh" {
  description = "SSH firewall"
  type = object({
    protocol : string
    ports : list(string)
  })
}

variable "firewall_ssh_name" {
  description = "Firewall for SSH"
  type        = string
}

variable "firewall_source_range" {
  description = "source range of firewall SSH"
  type        = list(any)
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

# Api and Service
variable "service_compute" {
  description = "enable service compute"
}

variable "service_container" {
  description = "enable service container"
}