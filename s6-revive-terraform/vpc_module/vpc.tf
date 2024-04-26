resource "aws_vpc" "revive_vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.vpc["instance_tenancy"]
  enable_dns_hostnames = var.vpc["enable_dns_hostnames"]
  enable_dns_support   = var.vpc["enable_dns_support"]

  tags = merge(var.tags, {
    Name = format("revive-%s-vpc", var.tags["id"])
    }
  )
}