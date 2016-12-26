variable "env" {}

variable "instance_name" {
  description = ""
}

variable "instance_type" {}

variable "subnets" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "ami_id" {}

variable "aws_security_group" {
  description = ""
}

variable "number_of_instances" {
  description = "number of instances to make"
}

variable "key_name" {
  description = "SSH key to use"
}

variable "org" {}

variable "fullaz" {}

variable "region" {}

variable "iam" {}

variable "tags" {
  default = {
    created_by = "terraform"
  }
}

variable "zone_id_public" {}

variable "zone_id_private" {}

variable "org_validator" {}
