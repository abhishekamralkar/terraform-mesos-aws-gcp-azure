resource "aws_subnet" "traefik_subnet" {
  vpc_id            = "${aws_vpc.demo.id}"
  cidr_block        = "${var.traefik_ranges}"
  availability_zone = "${var.traefik_region}"

  tags {
    Name = "${var.env}-${var.traefik_region}-traefik"
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "traefik_rt" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.env}-${var.traefik_region}-traefik"
  }
}

resource "aws_route" "traefik_rt_igw" {
  route_table_id         = "${aws_route_table.traefik_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo_igw.id}"
}

resource "aws_route_table_association" "traefik_rta" {
  subnet_id      = "${aws_subnet.traefik_subnet.id}"
  route_table_id = "${aws_route_table.traefik_rt.id}"
}
