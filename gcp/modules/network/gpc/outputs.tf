
output "network_name" {
  value = "${google_compute_network.demo-network.name}"
}

output "ip_range" {
  value = "${google_compute_network.demo-network.ipv4_range}"
}
