resource "aws_security_group" "monitor_sg" {
  tags {
    Name = "${var.env}-${var.region}-monitor"
  }

  name        = "${var.env}-${var.region}-monitor"
  description = "Allow ssh to ${var.env}-monitor from VPN"
  vpc_id      = "${aws_vpc.demo.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.vpn_sg.id}"]
  }


  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["183.87.60.142/32"]
}


  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }


  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.bastion_sg.id}"]
  }
}
