variable "instance_type" {}

variable "instance_name" {}

variable "iam" {}

variable "env" {}

variable "region" {}

variable "ami" {}

variable "azs" {}

variable "security_groups" {}

variable "small_az" {}

variable "asg_name" {}

variable "keyname" {}

variable "traefik_subnets" {
  type = "list"
}

variable "max_size" {}

variable "min_size" {}

variable "desired_capacity" {}

variable "health_check_grace_period" {}

variable "health_check_type" {}

variable "elb_name" {}

variable "launch_config_name" {}

variable "origin" {}
