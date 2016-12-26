//VPC related Output
output "${var.env}_vpc_id" {
  value = "${aws_vpc.demo.id}"
}

output "vpc_id" {
  value = "${aws_vpc.demo.id}"
}

output "public_internet_gw_id" {
  value = "${aws_internet_gateway.demo_igw.id}"
}

//Bastion related Output

output "bastion_sg_id" {
  value = "${aws_security_group.bastion_sg.id}"
}

output "bastion_subnet_id" {
  value = "${aws_subnet.bastion_subnet.id}"
}

//VPN related Output

output "vpn_subnet_id" {
  value = "${aws_subnet.vpn_subnet.id}"
}

output "vpn_sg_id" {
  value = "${aws_security_group.vpn_sg.id}"
}

//ELB related Output

output "cidr_block_0" {
  value = ["${aws_subnet.elb_subnet.*.cidr_block}"]
}

output "elb_subnet_id" {
  value = ["${aws_subnet.elb_subnet.*.id}"]
}

output "elb_subnet_id_0" {
  value = ["${aws_subnet.elb_subnet.*.id}"]
}

output "elb_sg_id" {
  value = "${aws_security_group.elb_sg.id}"
}

output "mesos_master_subnet_id" {
  value = "${aws_subnet.mesos_master_subnet.id}"
}

output "mesos_master_sg_id" {
  value = "${aws_security_group.mesos_master_sg.id}"
}

output "mesos_slave_subnet_id" {
  value = "${aws_subnet.mesos_slave_subnet.id}"
}

output "mesos_slave_sg_id" {
  value = "${aws_security_group.mesos_slave_sg.id}"
}


output "zookeeper_subnet_id" {
  value = "${aws_subnet.zookeeper_subnet.id}"
}

output "zookeeper_sg_id" {
  value = "${aws_security_group.zookeeper_sg.id}"
}



output "monitor_subnet_id" {
  value = "${aws_subnet.monitor_subnet.id}"
}

output "monitor_sg_id" {
  value = "${aws_security_group.monitor_sg.id}"
}


output "traefik_subnet_id" {
  value = "${aws_subnet.traefik_subnet.id}"
}

output "traefik_sg_id" {
  value = "${aws_security_group.traefik_sg.id}"
}


