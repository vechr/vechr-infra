output "cloudsql_service_account" {
  value = google_service_account.proxy_account.email
}

output "cloudsql_instance_name" {
  value = google_sql_database_instance.instance.name
}

output "cloudsql_settings_info" {
  value = google_sql_database_instance.instance.settings
}