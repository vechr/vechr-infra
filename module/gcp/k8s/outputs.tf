output "kubernetes_cluster_name" {
  value       = google_container_cluster.default.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.default.endpoint
  description = "GKE Cluster Host"
}

output "kubenetes_service_account_email" {
  description = "Service Account that used by kubernetes"
  value = google_service_account.kubernetes.email
}

output "node_pool_info_config" {
  description = "GKE node pool config"
  value = google_container_node_pool.default.node_config
}