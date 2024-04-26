aws_region   = "us-east-1"
cidr_block   = "10.10.0.0/16"
cluster_name = "dev-revive"
tags = {
  "id"             = "1300"
  "owner"          = "phase5"
  "teams"          = "PD"
  "environment"    = "dev"
  "project"        = "revive-vpc"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}

num_eip = 1
num_nat = 1

availability_zone = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
]