variable "sql_private_vpc_connection" {
  description = "SQL private VPC Connection"
}

variable "network" {
  description = "network self link"
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