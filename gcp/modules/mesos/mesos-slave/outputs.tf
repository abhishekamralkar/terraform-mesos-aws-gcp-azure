
output "mesos_slave_ips" {
  value = "${join(",", google_compute_instance.mesos-slave.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "mesos-slave_instances" {
  value = "${join(",", google_compute_instance.mesos-slave.*.self_link)}"
}

