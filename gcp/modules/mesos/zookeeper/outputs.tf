
output "zookeeper_ips" {
  value = "${join(",", google_compute_instance.zookeeper.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "zookeeper_instances" {
  value = "${join(",", google_compute_instance.zookeeper.*.self_link)}"
}

output "zookeeper_private_ips" {
    value = "${join(",", google_compute_instance.zookeeper.*.network_interface.0.address)}"
}

