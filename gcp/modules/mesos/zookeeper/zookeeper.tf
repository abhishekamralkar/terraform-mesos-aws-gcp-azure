# Instances
resource "google_compute_disk" "zookeeper_disk" {
  name = "${var.short_name}-${var.env}-lvm-${format("%03d", count.index)}"
  type = "${var.data_volume_type}"
  zone = "${element(split(",", var.zones), count.index)}"
  size = "${var.data_volume_size}"
  count = "${var.count}"
}

resource "google_compute_instance" "zookeeper" {
  name = "${var.short_name}-${var.role}-${format("%03d", count.index)}"
  description = "${var.short_name} ${var.env} node #${format("%03d", count.index)}"
  machine_type = "${var.machine_type}"
  zone = "${element(split(",", var.zones), count.index)}"
  can_ip_forward = true
  tags = ["${var.short_name}", "${var.env}"]

  disk {
    image = "${var.image}"
    type = "${var.volume_type}"
    size = "${var.volume_size}"
    auto_delete = true
  }

  disk {
    disk = "${element(google_compute_disk.zookeeper_disk.*.name, count.index)}"
    auto_delete = false

    device_name = "lvm"
  }

  network_interface {
    network = "${var.network_name}"
    access_config {}
  }

  metadata {
    dc = "${var.datacenter}"
    role = "${var.role}"
    sshKeys = "${var.ssh_user}:${file(var.ssh_key)} ${var.ssh_user}"
    ssh_user = "${var.ssh_user}"
  }

  service_account {
    scopes = ["${split(",", var.service_account_scopes)}"]
  }


  count = "${var.count}"

  provisioner "chef" {
    environment     = "${var.env}"
    run_list        = ["base_cb::default", "exhibitor::default", "exhibitor::service"]
    node_name       = "${var.name}-${format("%03d",count.index)}-${var.env}"
    user_name       = "${var.org_validator}"
    server_url      = "https://35.164.177.32/organizations/demoinc"
    user_key        = "${file("~/.chef/${var.org_validator}.pem")}"
    ssl_verify_mode = ":verify_none"
    version         = "12.15.19"

    connection {
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
  }

}

