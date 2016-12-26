variable "count" {default = "3"}
variable "org_validator" {}
variable "env" {}
variable "name" {}
variable "machine_type" {default = "n1-standard-1"}
variable "volume_size" {default = "20"} # size is in gigabytes
variable "volume_type" {default = "pd-standard"}
variable "data_volume_size" {default = "20"} # size is in gigabytes
variable "data_volume_type" {default = "pd-ssd"}
variable "datacenter" {}
variable "image" {}
variable "role" {}
variable "network_name" {}
variable "short_name" {}
variable "ssh_key" {}
variable "ssh_user" {}
variable "zones" {}
variable "service_account_scopes" { default = "compute-rw,monitoring,logging-write,storage-ro,https://www.googleapis.com/auth/ndev.clouddns.readwrite" }
variable "managed_zone" {}
variable "domain" {}
