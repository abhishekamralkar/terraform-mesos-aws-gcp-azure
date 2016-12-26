resource "aws_iam_role" "demo-mesos-slave-iam" {
  name = "demo-mesos-slave-iam-${var.env}"

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

resource "aws_iam_instance_profile" "demo-mesos-slave-iam" {
  name  = "demo-mesos-slave-iam-${var.env}"
  roles = ["${aws_iam_role.demo-mesos-slave-iam.name}"]
}
