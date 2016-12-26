// Output the ID of the EC2 instance created
output "ec2_instance_id" {
  value = "${aws_instance.vpn.id}"
}

output "vpn_ip" {
  value = "${aws_instance.vpn.public_ip}"
}
