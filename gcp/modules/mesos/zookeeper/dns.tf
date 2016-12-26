resource "google_dns_record_set" "zookeeper" {
  count = "${var.count}"
  managed_zone = "${var.managed_zone}"
  name = "zookeeper-${format("%03d", count.index)}-${var.env}.${var.domain}."
  type = "A"
  ttl = 60
  rrdatas = ["${element(google_compute_instance.zookeeper.*.network_interface.0.address, count.index)}"]
}



