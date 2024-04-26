resource "aws_security_group" "jenkins_sg" {
  name   = format("%s-%s-jenkins-sg", var.tags["project"], var.tags["environment"])
  vpc_id = data.aws_vpc.revive_vpc.id
  tags = merge(var.tags, {
    Name = format("jenkins-%s-%s-sg", var.tags["project"], var.tags["environment"])
    },
  )
}

resource "aws_security_group" "bastion_sg" {
  name   = format("%s-%s-bastion-sg", var.tags["project"], var.tags["environment"])
  vpc_id = data.aws_vpc.revive_vpc.id
  tags = merge(var.tags, {
    Name = format("bastion-%s-%s-sg", var.tags["project"], var.tags["environment"])
    },
  )
}

resource "aws_security_group" "lb_sg" {
  name   = format("%s-%s-lb-sg", var.tags["project"], var.tags["environment"])
  vpc_id = data.aws_vpc.revive_vpc.id
  tags = merge(var.tags, {
    Name = format("lb-%s-%s-sg", var.tags["project"], var.tags["environment"])
    },
  )
}