resource "aws_route53_zone_association" "private-zone-association" {
  zone_id = "${var.zone_id_private}"
  vpc_id  = "${aws_vpc.demo.id}"
}
