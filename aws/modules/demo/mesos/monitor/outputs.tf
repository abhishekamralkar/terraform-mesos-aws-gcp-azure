// Output the ID of the EC2 instance created
output "ec2_instance_id" {
  value = "${aws_instance.monitor.id}"
}

output "monitor_ip" {
  value = "${aws_instance.monitor.public_ip}"
}
