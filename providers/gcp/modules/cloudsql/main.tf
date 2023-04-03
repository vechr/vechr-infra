resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  name                = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-private-instance-${random_id.db_name_suffix.hex}"
  region              = var.region
  database_version    = "POSTGRES_14"
  deletion_protection = false
  depends_on          = [var.sql_private_vpc_connection]

  settings {
    tier              = "db-f1-micro"
    disk_type         = "PD_SSD"
    disk_size         = 10
    availability_type = "ZONAL"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network.id
    }
  }
}

resource "google_sql_user" "users" {
  name     = "${var.organization}-${var.application_code}-${var.region}-${var.environment}-user"
  instance = google_sql_database_instance.instance.name
  password = var.password_db
}