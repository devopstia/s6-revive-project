data "aws_subnet" "bastion_sub_pub" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pub_subnet-2"]
  }
}