resource "aws_launch_template" "jenkins_launch_template" {
  name                   = format("%s-%s-jenkins-launch-template", var.tags["project"], var.tags["environment"])
  image_id               = data.aws_ami.jenkins_ami.id
  instance_type          = var.instance_type
  key_name               = data.aws_key_pair.jen_key.key_name
  vpc_security_group_ids = [data.aws_security_group.revive_sg.id]
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = var.volume_size
      volume_type = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.jenkins_ec2_profile.name
  }
  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = format("%s-revive-jenkins", var.tags["id"])
    })
  }

  tags = merge(var.tags, {
    Name = format("%s-jenkins-launch-template", var.tags["project"])
    },
  )
  depends_on = [
    aws_iam_role.jenkins_revive_role
  ]
}