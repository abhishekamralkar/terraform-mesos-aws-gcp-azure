# AWS VPC creation code

resource "aws_vpc" "demo" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name = "${var.region}-${var.env}"
  }
}

# AWS VPC Internet Gateway Code
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.env}-${var.region}-igw"
  }
}

# refactor to take all the route {} sections out of routing tables,
# and turn them into associated aws_route resources
# so we can add vpc peering routes from specific environments.
resource "aws_route_table" "demo_rt" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.env}-${var.rt}"
  }
}

# add a public gateway to each public route table
resource "aws_route" "demo_rt_igw" {
  route_table_id         = "${aws_route_table.demo_rt.id}"
  depends_on             = ["aws_route_table.demo_rt"]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo_igw.id}"
}

resource "aws_main_route_table_association" "demo_rta" {
  vpc_id         = "${aws_vpc.demo.id}"
  route_table_id = "${aws_route_table.demo_rt.id}"
}

resource "aws_eip" "nat_eip" {
  count = "${length(split(",", var.nat_gw_range))}"
  vpc   = true
}

resource "aws_subnet" "nat_gw_subnet" {
  vpc_id            = "${aws_vpc.demo.id}"
  cidr_block        = "${element(split(",", var.nat_gw_range), count.index)}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(compact(split(",", var.nat_gw_range)))}"

  tags {
    Name = "${var.env}-${element(split(",", var.azs), count.index)}-${var.usecase1}"
  }

  map_public_ip_on_launch = true
}

resource "aws_nat_gateway" "nat_gw" {
  count         = "${length(split(",", var.nat_gw_range))}"
  allocation_id = "${element(aws_eip.nat_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.nat_gw_subnet.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.demo_igw"]
}

resource "aws_route_table" "nat_gw_rt" {
  vpc_id = "${aws_vpc.demo.id}"

  tags {
    Name = "${var.usecase1}-${var.env}-${var.rt}"
  }
}

resource "aws_route" "nat_igw_route" {
  route_table_id         = "${aws_route_table.nat_gw_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo_igw.id}"
  depends_on             = ["aws_route_table.nat_gw_rt"]
}
