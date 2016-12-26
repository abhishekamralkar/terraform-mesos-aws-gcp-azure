// Output the ID of the EC2 instance created
output "ec2_instance_id" {
  value = "${aws_instance.bastion-demo.id}"
}

output "bastion_ip" {
  value = "${aws_instance.bastion-demo.public_ip}"
}
