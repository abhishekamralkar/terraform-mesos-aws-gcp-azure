resource "aws_subnet" "bastion_subnet" {
  vpc_id            = "${aws_vpc.demo.id}"
  cidr_block        = "${var.bastion_ranges}"
  availability_zone = "${var.bastion_region}"

  tags {
    Name = "${var.env}-${var.bastion_region}-bastion"
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "bastion_rt" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.env}-${var.bastion_region}-bastion"
  }
}

resource "aws_route" "bastion_rt_igw" {
  route_table_id         = "${aws_route_table.bastion_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo_igw.id}"
}

resource "aws_route_table_association" "bastion_rta" {
  subnet_id      = "${aws_subnet.bastion_subnet.id}"
  route_table_id = "${aws_route_table.bastion_rt.id}"
}
