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

# API and Service
variable "service" {
  description = "Service name"
  type = string
}

variable "disable_dependent_services" {
  description = "Disable dependent services"
}

variable "disable_on_destroy" {
  description = "Disable on destroy"
}