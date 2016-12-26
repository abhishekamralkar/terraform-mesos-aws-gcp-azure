resource "aws_security_group" "elb_sg" {
  tags {
    Name = "${var.env}-${var.region}-traefik-${var.env_lb}"
  }

  name        = "${var.env}-${var.region}-traefik-${var.env_lb}"
  description = "${var.env}-${var.region}-traefik-${var.env_lb}"
  vpc_id      = "${aws_vpc.demo.id}"
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
