resource "aws_subnet" "vpn_subnet" {
  vpc_id            = "${aws_vpc.demo.id}"
  cidr_block        = "${var.vpn_ranges}"
  availability_zone = "${var.vpn_region}"

  tags {
    Name = "${var.env}-${var.region}--vpn"
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "vpn_rt" {
  vpc_id = "${aws_vpc.demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo_igw.id}"
  }

  tags {
    Name = "${var.env}-vpn-subnet_route_table"
  }
}

resource "aws_route_table_association" "vpn_rta" {
  subnet_id      = "${aws_subnet.vpn_subnet.id}"
  route_table_id = "${aws_route_table.vpn_rt.id}"
}
