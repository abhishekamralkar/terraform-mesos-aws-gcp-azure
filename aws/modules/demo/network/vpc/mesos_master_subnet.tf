resource "aws_subnet" "mesos_master_subnet" {
  vpc_id            = "${aws_vpc.demo.id}"
  cidr_block        = "${var.mesos_master_ranges}"
  availability_zone = "${var.mesos_master_region}"

  tags {
    Name = "${var.env}-${var.mesos_master_region}-mesos_master"
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "mesos_master_rt" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.env}-${var.mesos_master_region}-mesos_master"
  }
}

resource "aws_route" "mesos_master_rt_igw" {
  route_table_id         = "${aws_route_table.mesos_master_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo_igw.id}"
}

resource "aws_route_table_association" "mesos_master_rta" {
  subnet_id      = "${aws_subnet.mesos_master_subnet.id}"
  route_table_id = "${aws_route_table.mesos_master_rt.id}"
}
