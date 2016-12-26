resource "aws_subnet" "mesos_slave_subnet" {
  vpc_id            = "${aws_vpc.demo.id}"
  cidr_block        = "${var.mesos_slave_ranges}"
  availability_zone = "${var.mesos_slave_region}"

  tags {
    Name = "${var.env}-${var.mesos_slave_region}-mesos-slave"
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "mesos_slave_rt" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.env}-${var.mesos_slave_region}-mesos-slave"
  }
}

resource "aws_route" "mesos_slave_rt_igw" {
  route_table_id         = "${aws_route_table.mesos_slave_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo_igw.id}"
}

resource "aws_route_table_association" "mesos_slave_rta" {
  subnet_id      = "${aws_subnet.mesos_slave_subnet.id}"
  route_table_id = "${aws_route_table.mesos_slave_rt.id}"
}
