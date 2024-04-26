variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.10.0.0/16"
}


variable "common_tags" {
  type = map(any)
  default = {
    "AssetID"       = "2560"
    "AssetName"     = "Insfrastructure"
    "Teams"         = "DEL"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
  }
}

variable "subnets_cidr_block" {
  type = list(any)
  default = [
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24",
    "10.10.4.0/24",
    "10.10.5.0/24",
    "10.10.6.0/24"
  ]
}

variable "availability_zone" {
  type = list(any)
  default = [
    "us-east-1a",
    "us-east-1b",
  ]
}

variable "cluster_name" {
  type    = string
  default = "dev-revive"
}

