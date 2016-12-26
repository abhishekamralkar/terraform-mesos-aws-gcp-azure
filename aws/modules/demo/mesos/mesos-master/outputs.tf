// Output the ID of the EC2 instance created
output "ec2_instance_id" {
  value = "${aws_instance.mesos-master.id}"
}

output "mesos_master_ip" {
  value = "${aws_instance.mesos-master.public_ip}"
}

output "mesos_master_trigger" {
  value = "${join(",", aws_instance.mesos-master.*.id)}"
}
