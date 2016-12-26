#All VPC related variable should be set from here
module "vpc" {
  source                    = "../../modules/demo/network/vpc/"
  name                      = "demo"
  env                       = "demo"
  region                    = "us-west-2"
  usecase                   = "demo"
  usecase1                  = "nat_gw"
  env_pub                   = "public"
  env_pvt                   = "private"
  rt                        = "route-table"
  cidr                      = "10.0.0.0/16"
  private_ranges            = "10.0.1.0/24,10.0.2.0/24"
  public_ranges             = "10.0.3.0/24,10.0.4.0/24"
  small_az                  = "a,b"
  nat_gw_range              = "10.0.5.0/24"
  azs                       = "us-west-2a,us-west-2b,us-west-2c"
  bastion_ranges            = "10.0.11.0/24"
  bastion_ip                = "${module.bastion.bastion_ip}/32"
  bastion_region            = "us-west-2a"
  vpn_ranges                = "10.0.21.0/24"
  vpn_region                = "us-west-2a"
  mesos_master_ranges       = "10.0.41.0/24"
  mesos_master_region       = "us-west-2a"
  mesos_slave_ranges        = "10.0.42.0/24"
  mesos_slave_region        = "us-west-2a"
  zookeeper_region          = "us-west-2a"
  zookeeper_ranges          = "10.0.71.0/24"
  monitor_region            = "us-west-2a"
  monitor_ranges            = "10.0.121.0/24"
  traefik_region            = "us-west-2a"
  traefik_ranges            = "10.0.141.0/24"
  zone_id_private           = "${var.zone_id_private}"
  zone_id_public            = "${var.zone_id_public}"
  env_lb                    = "elb"
#  ct_elb_public_ranges      = "10.0.161.0/24,10.0.162.0/24"
#  ept_elb_public_ranges     = "10.0.163.0/24,10.0.164.0/24"
#  adminui_elb_public_ranges = "10.0.171.0/24,10.0.172.0/24"
#  portal_elb_public_ranges  = "10.0.181.0/24,10.0.182.0/24"
  elb_public_ranges    = "10.0.191.0/24,10.0.192.0/24"
}

#IAM related modules

module "iam" {
  source = "../../modules/demo/aws/iam/"
  env    = "demo"
}

#All Bastion related variable should be set from here
module "bastion" {
  source              = "../../modules/demo/mesos/bastion/"
  key_name            = "infrastructure-provisioner"
  aws_security_group  = "${module.vpc.bastion_sg_id}"
  org                 = "demo"
  region              = "us-west-2"
  fullaz              = "us-west-2a"
  env                 = "demo"
  instance_type       = "t2.micro"
  instance_name       = "bastion"
  iam                 = "demo-bastion-iam-demo"
  ami_id              = "ami-f319c293"
  subnets             = "${module.vpc.bastion_subnet_id}"
  org_validator       = "demoinc-validator"
  number_of_instances = 1
  env                 = "demo"
  zone_id_public      = "${var.zone_id_public}"
  zone_id_private     = "${var.zone_id_private}"
}

#All VPN related variable should be set from here
module "vpn" {
  source              = "../../modules/demo/mesos/vpn/"
  key_name            = "infrastructure-provisioner"
  aws_security_group  = "${module.vpc.vpn_sg_id}"
  org                 = "demosys"
  region              = "us-west-2"
  fullaz              = "us-west-2a"
  env                 = "demo"
  instance_type       = "t2.micro"
  instance_name       = "vpn"
  iam                 = "demo-vpn-iam-demo"
  ami_id              = "ami-f319c293"
  subnets             = "${module.vpc.vpn_subnet_id}"
  number_of_instances = 1
  org_validator       = "demoinc-validator"
  zone_id_public      = "${var.zone_id_public}"
  zone_id_private     = "${var.zone_id_private}"
}



#All Mesos Master related variable should be set from here
module "mesos-master" {
  source              = "../../modules/demo/mesos/mesos-master/"
  key_name            = "infrastructure-provisioner"
  aws_security_group  = "${module.vpc.mesos_master_sg_id}"
  org                 = "demo"
  region              = "us-west-2"
  fullaz              = "us-west-2a"
  env                 = "demo"
  instance_type       = "t2.micro"
  instance_name       = "mesos-master"
  iam                 = "demo-mesos-master-iam-demo"
  ami_id              = "ami-f319c293"
  subnets             = "${module.vpc.mesos_master_subnet_id}"
  org_validator       = "demoinc-validator"
  number_of_instances = 3
  env                 = "demo"
  zone_id_public      = "${var.zone_id_public}"
  zone_id_private     = "${var.zone_id_private}"
  depends_on          = "${module.zookeeper.zookeeper_trigger}"
}

#All Mesos Master related variable should be set from here
module "mesos-slave" {
  source              = "../../modules/demo/mesos/mesos-slave/"
  key_name            = "infrastructure-provisioner"
  aws_security_group  = "${module.vpc.mesos_slave_sg_id}"
  org                 = "demo"
  region              = "us-west-2"
  fullaz              = "us-west-2a"
  env                 = "demo"
  instance_type       = "t2.micro"
  instance_name       = "mesos-slave"
  iam                 = "demo-mesos-slave-iam-demo"
  ami_id              = "ami-f319c293"
  subnets             = "${module.vpc.mesos_slave_subnet_id}"
  org_validator       = "demoinc-validator"
  number_of_instances = 2
  env                 = "demo"
  zone_id_public      = "${var.zone_id_public}"
  zone_id_private     = "${var.zone_id_private}"
  depends_on          = "${module.mesos-master.mesos_master_trigger}"
}


#All Zookeeper related variable should be set from here
module "zookeeper" {
  source              = "../../modules/demo/mesos/zookeeper/"
  key_name            = "infrastructure-provisioner"
  aws_security_group  = "${module.vpc.zookeeper_sg_id}"
  org                 = "demo"
  region              = "us-west-2"
  fullaz              = "us-west-2a"
  env                 = "demo"
  instance_type       = "t2.micro"
  instance_name       = "zookeeper"
  iam                 = "demo-zk-iam-demo"
  ami_id              = "ami-f319c293"
  subnets             = "${module.vpc.zookeeper_subnet_id}"
  org_validator       = "demoinc-validator"
  number_of_instances = 3
  env                 = "demo"
  zone_id_public      = "${var.zone_id_public}"
  zone_id_private     = "${var.zone_id_private}"
}



#All Monitor related variable should be set from here
module "monitor" {
  source              = "../../modules/demo/mesos/monitor/"
  key_name            = "infrastructure-provisioner"
  aws_security_group  = "${module.vpc.monitor_sg_id}"
  org                 = "demo"
  region              = "us-west-2"
  fullaz              = "us-west-2a"
  env                 = "demo"
  instance_type       = "t2.micro"
  instance_name       = "monitor"
  iam                 = "demo-monitor-iam-demo"
  ami_id              = "ami-f319c293"
  subnets             = "${module.vpc.monitor_subnet_id}"
  org_validator       = "demoinc-validator"
  number_of_instances = 1
  env                 = "demo"
  zone_id_public      = "${var.zone_id_public}"
  zone_id_private     = "${var.zone_id_private}"
}

module "elb" {
  source                      = "../../modules/demo/aws/elb/"
  elb_name                    = "traefik"
  service                     = "elb"
  region                      = "us-west-2"
  env                         = "demo"
  application_short           = "traefik"
  app_short                   = "traefik"
  elb_security_group          = "${module.vpc.elb_sg_id}"
  subnets                     = "${module.vpc.elb_subnet_id_0}"
  instances                   = ["${module.traefik.ec2_instance_id_0}"]
  backend_port                = "80"
  env                         = "demo"
  zone_id_public              = "${var.zone_id_public}"
  log_bucket                  = "demo-elbtraefik-logs"
  log_bucket_prefix           = "traefik"
  health_check_target         = "HTTP:31016/health"
  healthy_threshold_check     = "2"
  unhealthy_threshold_check   = "2"
  timeout                     = "3"
  interval                    = "30"
  idle_timeout                = "400"
  connection_draining_timeout = "400"
}

#module "asg" {
#  source        = "../../modules/demo/aws/asg/"
#  instance_type = "t2.micro"
#  ami           = "ami-f319c293"
#  iam           = "demo-mesos-slave-iam-demo"
#  env           = "demo"
#  region        = "uswest2"
#  azs           = "us-west-2a,us-west-2c"
#  small_az      = "a,c"
#  launch_config_name = "mesos-agent-asg-lc"
#  asg_name      = "traefik-asg"
#  subnets   = "${module.vpc.mesos_slave_subnet_id}"
#   aws_security_group  = "${module.vpc.mesos_slave_sg_id}"
#  instance_name = "mesos-agents-asg"
#  keyname       = "infrastructure-provisioner"
#  max_size      = "10"
#  min_size      = "0"
#  desired_capacity = "0"
#  health_check_grace_period = "300"
#  health_check_type     = "EC2"
#  elb_name      = "${module.elb.elb_name}"
#}

module "traefik" {
  source              = "../../modules/demo/mesos/traefik/"
  key_name            = "infrastructure-provisioner"
  aws_security_group  = "${module.vpc.traefik_sg_id}"
  org                 = "demo"
  region              = "us-west-2"
  fullaz              = "us-west-2a"
  env                 = "demo"
  instance_type       = "t2.micro"
  instance_name       = "traefik"
  iam                 = "demo-traefik-iam-demo"
  ami_id              = "ami-f319c293"
  subnets             = "${module.vpc.traefik_subnet_id}"
  org_validator       = "demoinc-validator"
  number_of_instances = 1
  env                 = "demo"
  zone_id_public      = "${var.zone_id_public}"
  zone_id_private     = "${var.zone_id_private}"
}
