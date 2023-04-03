variable "google_credentials" {
  type        = string
  description = "Environment Variable Google Credentials"
}

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

## VPC

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

variable "router_name" {
  description = "Name of your router"
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

# Network Service
variable "nat_name" {
  description = "Name of your NAT"
}

# k8s
variable "cluster_name" {
  description = "Name of Cluster Kubernetes"
}

# SQL
variable "password_db" {
  type        = string
  description = "Password Default Database"
}
variable "sa_proxy_cloud_sql" {
  type        = string
  description = "User Account for cloud proxy sql"
}

variable "machine_type" {
  type        = string
  description = "Machine Type of k8s cluster"
}

variable "max_node_count" {
  type        = number
  description = "Number of Max Node"
}