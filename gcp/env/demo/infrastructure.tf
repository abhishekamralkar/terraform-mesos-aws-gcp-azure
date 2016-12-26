module "demo-network" {
  source = "../../modules/network/gpc/"
  network_ipv4 = "10.0.0.0/16"
  long_name = "demo"
  short_name = "demo"
}

module "bastion" {
  source = "../../modules/mesos/bastion/"
  count = "1"
  datacenter = "demo"
  image = "ubuntu-1404-lts"
  machine_type = "n1-standard-1"
  network_name = "${module.demo-network.network_name}"
  role = "bastion"
  short_name = "bas"
  ssh_user = "ubuntu"
  ssh_key = "~/.ssh/id_rsa.pub"
  zones = "us-east1-b"
  volume_type = "pd-ssd"
  org_validator = "demoinc-validator"
  name      = "bastion"
  env       = "demo"
  managed_zone = "demo"
  domain      = "demo.com"
}

module "zookeeper" {
  source = "../../modules/mesos/zookeeper/"
  count = "3"
  datacenter = "demo"
  image = "ubuntu-1404-lts"
  machine_type = "n1-standard-1"
 network_name = "${module.demo-network.network_name}"
  role = "master"
  short_name = "zk"
  ssh_user = "ubuntu"
  ssh_key = "~/.ssh/id_rsa.pub"
  zones = "us-east1-b"
  volume_type = "pd-ssd"
 org_validator = "demoinc-validator"
 name      = "zookeeper"
 env       = "demo"
 managed_zone = "demo"
domain       = "demo.com"
}

module "mesos-master" {
 source = "../../modules/mesos/mesos-master/"
  count = "3"
  datacenter = "demo"
  image = "ubuntu-1404-lts"
  machine_type = "n1-standard-1"
  network_name = "${module.demo-network.network_name}"
  role = "master"
  short_name = "mm"
  ssh_user = "ubuntu"
  ssh_key = "~/.ssh/id_rsa.pub"
  zones = "us-east1-b"
  volume_type = "pd-ssd"
  org_validator = "demoinc-validator"
 name      = "mesos-master"
env       = "demo"
 managed_zone = "demo"
 domain = "demo.com"
}

module "mesos-slave" {
 source = "../../modules/mesos/mesos-slave/"
 count = "3"
  datacenter = "demo"
 image = "ubuntu-1404-lts"
  machine_type = "n1-standard-1"
 network_name = "${module.demo-network.network_name}"
 role = "slave"
  short_name = "ms"
 ssh_user = "ubuntu"
  ssh_key = "~/.ssh/id_rsa.pub"
 zones = "us-east1-b"
 volume_type = "pd-ssd"
  org_validator = "demoinc-validator"
 name      = "mesos-slave"
  env       = "demo"
 managed_zone = "demo"
 domain = "demo.com"
}

module "traefik" {
 source = "../../modules/mesos/traefik/"
 count = "1"
  datacenter = "demo"
 image = "ubuntu-1404-lts"
  machine_type = "n1-standard-1"
 network_name = "${module.demo-network.network_name}"
 role = "lb"
  short_name = "traefik"
 ssh_user = "ubuntu"
  ssh_key = "~/.ssh/id_rsa.pub"
 zones = "us-east1-b"
 volume_type = "pd-ssd"
  org_validator = "demoinc-validator"
 name      = "traefik"
  env       = "demo"
 managed_zone = "demo"
 domain = "demo.com"
}



module "traefik-lb" {
  source = "../../modules/gcs/lb/"
  instances = "${module.traefik.traefik_instances}"
  short_name = "traefik"
}
