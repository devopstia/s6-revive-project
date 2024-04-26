data "aws_vpc" "revive_vpc" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-vpc"]
  }
  filter {
    name   = "tag:environment"
    values = ["dev"]
  }
  filter {
    name   = "tag:project"
    values = ["revive-vpc"]
  }
}
