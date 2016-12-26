resource "aws_launch_configuration" "papi-traefik-asg-conf" {
  name_prefix          = "${var.launch_config_name}"
  image_id             = "${var.ami}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.iam}"
  key_name             = "${var.keyname}"
  security_groups      = ["${var.security_groups}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "papi-traefik-asg" {
  launch_configuration      = "${aws_launch_configuration.papi-traefik-asg-conf.id}"
  availability_zones        = ["${split(",", var.azs)}"]
  name                      = "${var.asg_name}"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  desired_capacity          = "${var.desired_capacity}"
  vpc_zone_identifier       = ["${var.traefik_subnets}"]
  load_balancers            = ["${var.elb_name}"]

  tag {
    key                 = "Name"
    value               = "${var.instance_name}-${format("%03d",count.index)}-${var.env}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Origin"
    value               = "${var.origin}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.env}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Nmonitor"
    value               = "true"
    propagate_at_launch = true
  }
}
