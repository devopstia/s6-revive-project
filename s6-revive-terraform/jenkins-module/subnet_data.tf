data "aws_subnet" "sub_pub" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pub_subnet-1"]
  }
}

data "aws_subnet" "sub_pub01" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pub_subnet-2"]
  }
}

data "aws_subnet" "sub_pri" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pri_subnet-1"]
  }
}