data "aws_ami" "jenkins_ami" {
  most_recent = true
  filter {
    name   = "tag:Name"
    values = ["jenkins-master-ami-*"]
  }

  filter {
    name   = "tag:id"
    values = ["1300"]
  }

  filter {
    name   = "tag:project"
    values = ["revive"]
  }
}