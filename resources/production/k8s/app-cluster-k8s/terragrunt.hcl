terraform {
  source = "../../../..//module/gcp/k8s"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc/private-network-app-k8s"
}

inputs = {
  cluster = {
    name: "iiot-cluster",
    remove_default_node_pool: true,
    initial_node_count: 1,
    disabled_load_balancing: false,
    disabled_horizontal_pod_autoscaling: false,
    pod_secondary_range_name: "pod-ip-range",
    services_secondary_range_name: "service-ip-range"
  }

  node_pool = {
    name : "general-node-pool"
    disk_size_gb : 20,
    disk_type : "pd-standard",
    machine_type : "e2-highcpu-8",
    preemptible : false,
    max_node_count : 20,
  }

  network = dependency.vpc.outputs.network
  subnetwork = dependency.vpc.outputs.subnetwork
}