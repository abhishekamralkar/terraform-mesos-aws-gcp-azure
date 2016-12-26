
output "bastion_ips" {
  value = "${join(",", google_compute_instance.instance.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "instances" {
  value = "${join(",", google_compute_instance.instance.*.self_link)}"
}
