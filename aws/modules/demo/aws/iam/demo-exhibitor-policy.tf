resource "aws_iam_policy" "demo_exhibitor_policy" {
  name        = "demo-${var.env}-exhibitor-access"
  description = "Access to Exhibitor Ticket"

  policy = <<EOF
{"Version":"2012-10-17","Statement":[{"Sid":"Stmt1386687089728","Action":["s3:AbortMultipartUpload","s3:DeleteObject","s3:GetBucketAcl","s3:GetBucketPolicy","s3:GetObject","s3:GetObjectAcl","s3:ListBucket","s3:ListBucketMultipartUploads","s3:ListMultipartUploadParts","s3:PutObject","s3:PutObjectAcl"],"Effect":"Allow","Resource":["arn:aws:s3:::zookeeper-demo-exhibitor/*","arn:aws:s3:::zookeeper-demo-exhibitor"]}]}
EOF
}

resource "aws_iam_policy_attachment" "demo_exhibitor_policy_attach" {
  name       = "${aws_iam_policy.demo_exhibitor_policy.name}"
  roles      = ["${aws_iam_role.demo-zk-iam.name}"]
  policy_arn = "${aws_iam_policy.demo_exhibitor_policy.arn}"
}
