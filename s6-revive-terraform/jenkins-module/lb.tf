resource "aws_lb" "jenkins_lb" {
  name               = "revive-jenkins-lb"
  internal           = var.internal
  load_balancer_type = var.lb_type
  security_groups    = [data.aws_security_group.revive_sg.id]
  subnets            = [data.aws_subnet.sub_pub.id, data.aws_subnet.sub_pub01.id]

  enable_deletion_protection = var.lb_protection

  tags = merge(var.tags, {
    Name = format("%s-revive-jenkins-lb", var.tags["id"])
  })

}

resource "aws_lb_listener" "jenkins_lb_listener_http" {
  load_balancer_arn = aws_lb.jenkins_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

  }
}

resource "aws_lb_listener" "jenkins_lb_listener_https" {
  load_balancer_arn = aws_lb.jenkins_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.cert_revive.arn
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_lb_tg.id
  }
}

resource "aws_lb_target_group" "jenkins_lb_tg" {
  name        = "revive-jenkins-tg"
  target_type = "instance"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.revive_vpc.id
  tags = merge(var.tags, {
    Name = format("revive-%s-jenkins-tg", var.tags["id"])
  })
}
