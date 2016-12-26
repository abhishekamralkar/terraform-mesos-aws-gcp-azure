
output "traefik_ips" {
  value = "${join(",", google_compute_instance.traefik.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "traefik_instances" {
  value = "${join(",", google_compute_instance.traefik.*.self_link)}"
}

