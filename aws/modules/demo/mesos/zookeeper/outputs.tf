// Output the ID of the EC2 instance created
output "ec2_instance_id" {
  value = "${aws_instance.zookeeper.id}"
}

output "zookeeper_ip" {
  value = "${aws_instance.zookeeper.public_ip}"
}

output "zookeeper_trigger" {
  value = "${join(",", aws_instance.zookeeper.*.id)}"
}
