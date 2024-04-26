data "aws_route53_zone" "revive_main" {
  name = var.domain_name
}

resource "aws_route53_record" "jenkins_record" {
  zone_id = data.aws_route53_zone.revive_main.zone_id
  name    = var.zone_sub
  type    = var.record_type
  ttl     = "300"
  records = [aws_lb.jenkins_lb.dns_name]

}