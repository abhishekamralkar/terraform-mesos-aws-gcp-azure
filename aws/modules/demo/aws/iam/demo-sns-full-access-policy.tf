resource "aws_iam_policy" "demo_sns_full_access_policy" {
  name        = "demo-sns-full-${var.env}-access"
  description = "SNS Full access"

  policy = <<EOF
{"Version":"2012-10-17","Statement":[{"Action":["sns:*"],"Effect":"Allow","Resource":"arn:aws:sns:us-east-1:660610034966:demo-*"}]}
EOF
}

resource "aws_iam_policy_attachment" "demo_sns_full_access_policy_attach" {
  name       = "${aws_iam_policy.demo_sns_full_access_policy.name}"
  roles      = ["${aws_iam_role.demo-base-iam.name}", "${aws_iam_role.demo-bastion-iam.name}", "${aws_iam_role.demo-mesos-master-iam.name}", "${aws_iam_role.demo-mesos-slave-iam.name}", "${aws_iam_role.demo-monitor-iam.name}", "${aws_iam_role.demo-vpn-iam.name}", "${aws_iam_role.demo-zk-iam.name}"]
  policy_arn = "${aws_iam_policy.demo_sns_full_access_policy.arn}"
}
