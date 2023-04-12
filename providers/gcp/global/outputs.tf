output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "nats_ip" {
  description = "nats ip global"
  value = module.vpc.nats_ip
}

output "ingress_ip" {
  description = "nats ip global"
  value = module.vpc.ingress_ip
}