variable "env" {}

variable "elb_name" {}

variable "elb_is_internal" {
  description = "Determines if the ELB is internal or not"
  default     = true
}

variable "elb_security_group" {}

variable "service" {}

variable "region" {}

variable "application_short" {}

variable "app_short" {}

variable "subnets" {
  type = "list"
}

variable "instances" {
  type = "list"
}

variable "backend_port" {
  description = "The port the service on the EC2 instances listens on"
}

variable "backend_protocol" {
  description = "The protocol the backend service speaks"

  // Possible options are
  default = "http"

  // - https

  // - tcp

  // - ssl (secure tcp)
}

variable "health_check_target" {
  description = "The URL the ELB should use for health checks"

  // This is primarily used with `http` or `https` backend protocols
  // The format is like `HTTPS:443/health`
  default = "HTTP:80/index.html"
}

variable "zone_id_public" {}

variable "log_bucket" {}

variable "log_bucket_prefix" {}

variable "healthy_threshold_check" {}

variable "unhealthy_threshold_check" {}

variable "timeout" {}

variable "interval" {}

variable "idle_timeout" {}

variable "connection_draining_timeout" {}
