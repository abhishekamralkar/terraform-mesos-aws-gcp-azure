resource "aws_subnet" "zookeeper_subnet" {
  vpc_id            = "${aws_vpc.demo.id}"
  cidr_block        = "${var.zookeeper_ranges}"
  availability_zone = "${var.zookeeper_region}"

  tags {
    Name = "${var.env}-${var.zookeeper_region}-zookeeper"
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "zookeeper_rt" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.env}-${var.zookeeper_region}-zookeeper"
  }
}

resource "aws_route" "zookeeper_rt_igw" {
  route_table_id         = "${aws_route_table.zookeeper_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo_igw.id}"
}

resource "aws_route_table_association" "zookeeper_rta" {
  subnet_id      = "${aws_subnet.zookeeper_subnet.id}"
  route_table_id = "${aws_route_table.zookeeper_rt.id}"
}
