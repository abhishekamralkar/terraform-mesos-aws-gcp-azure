#resource "aws_route53_record" "route-53-private" {

#  zone_id = "${var.zone_id_private}"

#  name    = "${var.instance_name}-${format("%03d",count.index)}-${var.az}"

#  type    = "CNAME"

#  ttl     = "60"

#  records = ["${aws_instance.bastion-staging.private_dns}"]

#}

resource "aws_route53_record" "route-53-public" {
  zone_id = "${var.zone_id_public}"
  name    = "${var.instance_name}-${format("%03d",count.index)}-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  count   = "${var.number_of_instances}"
  records = ["${element(aws_instance.mesos-slave.*.public_dns, count.index)}"]
}

resource "aws_route53_record" "route-53-private" {
  zone_id = "${var.zone_id_private}"
  name    = "${var.instance_name}-${format("%03d",count.index)}-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  count   = "${var.number_of_instances}"
  records = ["${element(aws_instance.mesos-slave.*.private_dns, count.index)}"]
}
