resource "aws_instance" "mesos-master" {
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
    Depends_On  = "${var.depends_on}"
  }
}

resource "null_resource" "chef-bootstrap-mesos-master" {
  provisioner "chef" {
    environment     = "${var.env}"
    run_list        = ["base_cb::default", "mesos::master", "role[consul_master]", "marathon::default", "marathon::service"]
    node_name       = "${var.instance_name}-000-${var.env}"
    user_name       = "${var.org_validator}"
    server_url      = "https://35.164.177.32/organizations/demoinc"
    user_key        = "${file("~/.chef/${var.org_validator}.pem")}"
    ssl_verify_mode = ":verify_none"
    version         = "12.15.19"

    connection {
      user        = "ubuntu"
      private_key = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      host        = "${aws_instance.mesos-master.0.public_ip}"
    }
  }
}

resource "null_resource" "chef-bootstrap-mesos-master2" {
  depends_on = ["null_resource.chef-bootstrap-mesos-master"]
  count      = "${var.number_of_instances - 1}"

  provisioner "chef" {
    environment     = "${var.env}"
    run_list        = ["base_cb::default", "mesos::master", "role[consul_master]", "marathon::default", "marathon::service"]
    node_name       = "${var.instance_name}-${format("%03d",count.index + 1)}-${var.env}"
    user_name       = "${var.org_validator}"
    server_url      = "https://35.164.177.32/organizations/demoinc"
    user_key        = "${file("~/.chef/${var.org_validator}.pem")}"
    ssl_verify_mode = ":verify_none"
    version         = "12.15.19"

    connection {
      user        = "ubuntu"
      private_key = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      host        = "${element(aws_instance.mesos-master.*.public_ip,count.index + 1)}"
    }
  }
}
