resource "aws_route53_record" "route-53-public" {
  zone_id = "${var.zone_id_public}"
  name    = "${var.app_short}"
  type    = "A"

  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }
}
