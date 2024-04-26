resource "aws_internet_gateway" "revive_igw" {
  vpc_id = aws_vpc.revive_vpc.id

  tags = merge(var.tags, {
    Name = format("revive-%s-igw", var.tags["id"])
    }
  )
}