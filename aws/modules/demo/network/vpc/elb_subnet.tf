# All ELB related subnet go in this section
resource "aws_subnet" "elb_subnet" {
  vpc_id            = "${aws_vpc.demo.id}"
  cidr_block        = "${element(split(",", var.elb_public_ranges), count.index)}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(compact(split(",", var.elb_public_ranges)))}"

  tags {
    Name = "${var.env}-${element(split(",", var.azs), count.index)}-${var.env_lb}"
  }

  map_public_ip_on_launch = true
}
