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

# IP Address
variable "ip_address" {
  description = "IP Address"
  type = object({
    name: string
    address_type: string
  })
}