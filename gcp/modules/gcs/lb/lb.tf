resource "google_compute_health_check" "default" {
  name = "${var.short_name}"
  timeout_sec        = 1
  check_interval_sec = 1
  http_health_check {
    port = "31016"
    request_path = "/health"
  }
}


resource "google_compute_forwarding_rule" "default" {
  name = "${var.short_name}-www-forwarding-rule"
  target = "${google_compute_target_pool.default.self_link}"
  port_range = "80"
}

resource "google_compute_target_pool" "default" {
  name = "${var.short_name}-www-target-pool"
  instances = ["${split(",", var.instances)}"]
  health_checks = ["${google_compute_health_check.default.name}"]
}

