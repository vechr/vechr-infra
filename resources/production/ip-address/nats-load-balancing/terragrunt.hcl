terraform {
  source = "../../../..//module/gcp/ip-address"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  ip_address = {
    name: "nats-ip",
    address_type: "EXTERNAL"
  }
}