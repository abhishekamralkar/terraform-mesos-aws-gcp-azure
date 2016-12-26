// Output the ID of the EC2 instance created
output "ec2_instance_id" {
  value = "${aws_instance.mesos-slave.id}"
}

output "mesos_slave_ip" {
  value = "${aws_instance.mesos-slave.public_ip}"
}
