data "aws_security_group" "bastion_sg" {
  filter {
    name   = "tag:Name"
    values = ["bastion-revive-dev-sg"]
  }
  tags = {
    "id"          = "1300"
    "Teams"       = "phase5"
    "environment" = "dev"
    "project"     = "revive"
    "createBy"    = "Terraform"
  }
}