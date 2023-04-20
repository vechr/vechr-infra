terraform {
  source = "../../../..//module/gcp/network-service"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc/private-network-app-k8s"
}

inputs = {
  nat_name = "nat-1"
  network = dependency.vpc.outputs.network
  router_name = "router-1"
}