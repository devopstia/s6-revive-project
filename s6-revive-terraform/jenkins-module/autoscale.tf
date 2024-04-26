resource "aws_autoscaling_group" "jenkins_autoscale" {
  name                = "jenkins_autoscale_gp"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [data.aws_subnet.sub_pri.id]
  target_group_arns   = [aws_lb_target_group.jenkins_lb_tg.arn]

  launch_template {
    id      = aws_launch_template.jenkins_launch_template.id
    version = "$Latest"
  }

}

resource "aws_autoscaling_policy" "jenkins_autoscale_policy" {
  name                   = "jenkins_autoscale_policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.jenkins_autoscale.name

  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 40.0
  }
}
