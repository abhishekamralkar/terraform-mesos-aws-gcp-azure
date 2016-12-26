// Output the ID of the EC2 instance created
output "ec2_instance_id_0" {
  value = "${aws_instance.traefik.0.id}"
}

output "traefik_ip_0" {
  value = "${aws_instance.traefik.0.public_ip}"
}

output "ec2_instance_id_1" {
  value = "${aws_instance.traefik.1.id}"
}

output "traefik_ip_1" {
  value = "${aws_instance.traefik.1.public_ip}"
}

output "ec2_instance_id_2" {
  value = "${aws_instance.traefik.2.id}"
}

output "traefik_ip_2" {
  value = "${aws_instance.traefik.2.public_ip}"
}
