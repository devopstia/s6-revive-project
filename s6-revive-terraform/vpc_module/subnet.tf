resource "aws_subnet" "revive_subnet_pub" {
  count             = length(var.availability_zone)
  vpc_id            = aws_vpc.revive_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zone))
  availability_zone = element(var.availability_zone, count.index)

  tags = merge(var.tags, {
    Name                                        = format("revive-%s-pub_subnet-${count.index + 1}", var.tags["id"])
    tier                                        = "public"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}
resource "aws_subnet" "revive_subnet_private" {
  count             = length(var.availability_zone)
  vpc_id            = aws_vpc.revive_vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 5, count.index + length(var.availability_zone))
  availability_zone = element(var.availability_zone, count.index)

  tags = merge(var.tags, {
    Name                                        = format("revive-%s-pri_subnet-${count.index + 1}", var.tags["id"])
    tier                                        = "private"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}

