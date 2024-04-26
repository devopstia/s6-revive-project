data "aws_subnet" "sub_pub1" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pub_subnet-1"]
  }
}

data "aws_subnet" "sub_pub2" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pub_subnet-2"]
  }
}

data "aws_subnet" "sub_pub3" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pub_subnet-3"]
  }
}