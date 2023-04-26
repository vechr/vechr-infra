terraform {
  source = "../../../..//module/gcp/global-ip-address"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  global_ip_address = {
    name: "ingress-ip",
    address_type: "EXTERNAL"
  }
}