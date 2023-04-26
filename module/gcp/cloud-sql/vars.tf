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

# Cloud SQL
variable "network" {
  description = "network self link"
}

variable "sa_proxy_cloud_sql" {
  type        = string
  description = "User Account for cloud sql"
}

# User and Password
variable "password_db" {
  type        = string
  description = "Password Default Database"
}