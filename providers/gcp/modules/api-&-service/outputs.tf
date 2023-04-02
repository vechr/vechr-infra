output "service_compute" {
  value = google_project_service.compute
}

output "service_container" {
  value = google_project_service.container
}

output "service_admin_api" {
  value = google_project_service.admin_api
}

output "service_networking_api" {
  value = google_project_service.networking_api
}