# Network
resource "google_compute_network" "demo-network" {
  name = "${var.long_name}"
  ipv4_range = "${var.network_ipv4}"
}

# Firewall
resource "google_compute_firewall" "demo-firewall-external" {
  name = "${var.short_name}-firewall-external"
  network = "${google_compute_network.demo-network.name}"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = [
      "22",   # SSH
      "80",   # HTTP
      "443",  # HTTPS
      "4400", # Chronos
      "5050", # Mesos
      "8080", # Marathon
      "8500",  # Consul API
      "8090"  # Exhibitor
]
  }
}

resource "google_compute_firewall" "demo-firewall-internal" {
  name = "${var.short_name}-firewall-internal"
  network = "${google_compute_network.demo-network.name}"
  source_ranges = ["${google_compute_network.demo-network.ipv4_range}"]

  allow {
    protocol = "tcp"
    ports = ["1-65535"]
  }

  allow {
    protocol = "udp"
    ports = ["1-65535"]
  }

  allow {
    protocol = "4"
  }
}
