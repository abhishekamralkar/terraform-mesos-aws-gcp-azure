resource "aws_subnet" "monitor_subnet" {
  vpc_id            = "${aws_vpc.demo.id}"
  cidr_block        = "${var.monitor_ranges}"
  availability_zone = "${var.monitor_region}"

  tags {
    Name = "${var.env}-${var.monitor_region}-monitor"
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "monitor_rt" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.env}-${var.monitor_region}-monitor"
  }
}

resource "aws_route" "monitor_rt_igw" {
  route_table_id         = "${aws_route_table.monitor_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo_igw.id}"
}

resource "aws_route_table_association" "monitor_rta" {
  subnet_id      = "${aws_subnet.monitor_subnet.id}"
  route_table_id = "${aws_route_table.monitor_rt.id}"
}
