terraform {
  source = "../../../..//module/gcp/api-and-service"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  service = "compute.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy = false
}