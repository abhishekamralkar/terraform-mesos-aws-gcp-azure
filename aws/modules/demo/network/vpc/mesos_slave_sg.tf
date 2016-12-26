resource "aws_security_group" "mesos_slave_sg" {
  tags {
    Name = "${var.env}-${var.region}-mesos-slave"
  }

  name        = "${var.env}-${var.region}-mesos-slave"
  description = "Allow ssh to ${var.env}-mesos-slave from VPN"
  vpc_id      = "${aws_vpc.demo.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = ["${aws_security_group.vpn_sg.id}"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["183.87.60.142/32"]
}
  
ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["114.143.194.102/32"]
}

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }
}


resource "aws_security_group_rule" "allow_from_master" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  security_group_id = "${aws_security_group.mesos_slave_sg.id}"
  source_security_group_id = "${aws_security_group.mesos_master_sg.id}"
}
