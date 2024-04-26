variable "aws_region" {
  type        = string
  description = "your desire aws region"
  default     = "us-east-1"
}
variable "num_nat" {
  type    = number
  default = 1
}
variable "num_eip" {
  type    = number
  default = 1
}
variable "tags" {
  type = map(any)
  default = {
    "id"             = "1300"
    "owner"          = "Phase5"
    "teams"          = "PD"
    "environment"    = "dev"
    "project"        = "revive-vpc"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "cidr_block" {
  type    = string
  default = ""
}

variable "availability_zone" {
  type = list(any)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
}
variable "vpc" {
  type = map(any)
  default = {
    instance_tenancy     = "default"
    enable_dns_hostnames = true
    enable_dns_support   = true

  }
}

variable "cluster_name" {
  type    = string
  default = ""
}