resource "aws_instance" "monitor" {
  ami                    = "${var.ami_id}"
  availability_zone      = "${var.fullaz}"
  count                  = "${var.number_of_instances}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.aws_security_group}"]
  subnet_id              = "${var.subnets}"
  instance_type          = "${var.instance_type}"
  iam_instance_profile   = "${var.iam}"
  source_dest_check      = false

  tags {
    created_by  = "${lookup(var.tags,"created_by")}"
    Name        = "${var.instance_name}-${format("%03d",count.index)}-${var.env}"
    Environment = "${var.env}"
  }
}

resource "null_resource" "chef-bootstrap-monitor" {
  count = "${var.number_of_instances}"

  provisioner "chef" {
    environment     = "${var.env}"
    run_list        = ["base_cb::default", "role[riemann_server]"]
    node_name       = "${var.instance_name}-${format("%03d",count.index)}-${var.env}"
    user_name       = "${var.org_validator}"
    server_url      = "https://35.164.177.32/organizations/demoinc"
    user_key        = "${file("~/.chef/${var.org_validator}.pem")}"
    ssl_verify_mode = ":verify_none"
    version         = "12.15.19"

    connection {
      user        = "ubuntu"
      private_key = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      host        = "${element(aws_instance.monitor.*.public_ip, count.index)}"
    }
  }
}
