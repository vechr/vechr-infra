variable "network" {
  description = "network self link"
}

variable "service_networking_api" {
  description = "enable service networking api"
}
variable "sa_proxy_cloud_sql" {
  type        = string
  description = "User Account for cloud sql"
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

# User and Password
variable "password_db" {
  type        = string
  description = "Password Default Database"
}