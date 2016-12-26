output "citadel_policy_arn" {
  value = "${aws_iam_policy.citadel_policy.arn}"
}



output "demo_exhibitor_policy_arn" {
  value = "${aws_iam_policy.demo_exhibitor_policy.arn}"
}




output "demo_sns_full_access_policy_arn" {
  value = "${aws_iam_policy.demo_sns_full_access_policy.arn}"
}
