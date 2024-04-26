data "aws_subnet" "sub_priv1" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pri_subnet-1"]
  }
}

data "aws_subnet" "sub_priv2" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pri_subnet-2"]
  }
}

data "aws_subnet" "sub_priv3" {
  filter {
    name   = "tag:Name"
    values = ["revive-1300-pri_subnet-3"]
  }
}