output "domain" {
  value = "${aws_route53_record.jenkins_record.name}.${var.domain_name}"
}