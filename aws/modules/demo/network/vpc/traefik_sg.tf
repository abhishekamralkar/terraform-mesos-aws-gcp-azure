resource "aws_security_group" "traefik_sg" {
  tags {
    Name = "${var.env}-${var.region}-traefik"
  }

  name        = "${var.env}-${var.region}-traefik"
  description = "Allow ssh to ${var.env}-traefik from VPN"
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
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["183.87.60.142/32"]
}


ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["114.143.194.102/32"]
}
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb_sg.id}"]
  }

  ingress {
    from_port       = 31016
    to_port         = 31016
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb_sg.id}"]
  }

  
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }
}
