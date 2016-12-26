resource "aws_iam_policy" "citadel_policy" {
  name        = "citadel-${var.env}-access"
  description = "Access to Citadel Secrets"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:List*",
                "s3:Get*"
            ],
            "Resource": [
		"arn:aws:s3:::demo-${var.env}-info",
                "arn:aws:s3:::demo-${var.env}-info/keys",
                "arn:aws:s3:::demo-${var.env}-info/keys/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "citadel_policy_attach" {
  name       = "${aws_iam_policy.citadel_policy.name}"
  roles      = ["${aws_iam_role.demo-base-iam.name}", "${aws_iam_role.demo-bastion-iam.name}", "${aws_iam_role.demo-mesos-master-iam.name}", "${aws_iam_role.demo-mesos-slave-iam.name}", "${aws_iam_role.demo-monitor-iam.name}", "${aws_iam_role.demo-vpn-iam.name}", "${aws_iam_role.demo-zk-iam.name}"]
  policy_arn = "${aws_iam_policy.citadel_policy.arn}"
}
