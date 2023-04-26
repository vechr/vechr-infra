terraform {
  source = "../../../..//module/gcp/vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  network_name = "vpc-1"
  routing_mode = "REGIONAL"
  subnet = {
    name: "private",
    ip_cidr_range: "10.5.0.0/20",
    private_ip_google_access: true,
    pod_secondary_ip: {
      range_name : "pod-ip-range", ip_cidr_range : "10.0.0.0/14"
    },
    services_secondary_ip: {
      range_name : "service-ip-range", ip_cidr_range : "10.4.0.0/19"
    }
  }

  firewall = {
    name: "allow-ssh",
    source_ranges: ["0.0.0.0/0"],
    allow: {
      protocol : "tcp"
      ports    : ["22"]
    }
  }
}