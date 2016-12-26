variable "name" {}

variable "env" {}

variable "region" {}

variable "usecase" {}

variable "env_pub" {}

variable "env_pvt" {}

variable "cidr" {}

variable "public_ranges" {
  default = ""
}

variable "usecase1" {}

variable "private_ranges" {
  default = ""
}

variable "azs" {}

variable "small_az" {}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "rt" {}

variable "nat_gw_range" {}

variable "zone_id_public" {}

variable "zone_id_private" {}

variable "bastion_ip" {}

variable "bastion_ranges" {}

variable "bastion_region" {}

variable "vpn_ranges" {}

variable "vpn_region" {}


variable "elb_public_ranges" {
  default = ""
}


variable "env_lb" {}

variable "mesos_master_ranges" {}

variable "mesos_master_region" {}

variable "mesos_slave_ranges" {}

variable "mesos_slave_region" {}


variable "zookeeper_ranges" {}

variable "zookeeper_region" {}

variable "monitor_ranges" {}

variable "monitor_region" {}

variable "traefik_ranges" {}

variable "traefik_region" {}

