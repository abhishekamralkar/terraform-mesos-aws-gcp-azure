
output "mesos_master_ips" {
  value = "${join(",", google_compute_instance.mesos-master.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "mesos-master_instances" {
  value = "${join(",", google_compute_instance.mesos-master.*.self_link)}"
}

