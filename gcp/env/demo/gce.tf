variable "region" {
  default = "us-east1-b"
}

provider "google" {
  credentials = "${file("~/.gce/terraform-demo.json")}"
  project     = "terraform-demo-152315"
  region      = "${var.region}"
}
