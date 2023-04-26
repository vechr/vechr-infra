terraform {
  source = "../../../..//module/gcp/network-service"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../../vpc/private-network-app-k8s"]
}

dependency "vpc" {
  config_path = "../../vpc/private-network-app-k8s"

  mock_outputs = {
    network = "temporary-vpc-network"
  }
  
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = {
  nat_name = "nat-1"
  network = dependency.vpc.outputs.network
  router_name = "router-1"
}