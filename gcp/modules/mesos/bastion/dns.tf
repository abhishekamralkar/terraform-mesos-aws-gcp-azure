resource "google_dns_record_set" "bastion" {
  count = "${var.count}"
  managed_zone = "${var.managed_zone}"
  name = "bastion-${format("%03d", count.index)}-${var.env}.${var.domain}."
  type = "A"
  ttl = 60
  rrdatas = ["${element(google_compute_instance.instance.*.network_interface.0.access_config.0.assigned_nat_ip, count.index)}"]
}



