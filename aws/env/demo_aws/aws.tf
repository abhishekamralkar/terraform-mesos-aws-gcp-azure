provider "aws" {
  region = "us-west-2"
}

resource "terraform_remote_state" "remote_state" {
  backend = "s3"

  config {
    bucket = "demo-terra-state"
    key    = "demo/terraform.tfstate"
    region = "us-west-2"
  }
}
