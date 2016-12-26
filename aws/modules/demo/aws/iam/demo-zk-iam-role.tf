resource "aws_iam_role" "demo-zk-iam" {
  name = "demo-zk-iam-${var.env}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "demo-zk-iam" {
  name  = "demo-zk-iam-${var.env}"
  roles = ["${aws_iam_role.demo-zk-iam.name}"]
}
