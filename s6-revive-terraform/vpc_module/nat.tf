resource "aws_nat_gateway" "revive_nat_gateway" {
  count             = var.tags["environment"] == "production" ? length(var.availability_zone) : var.num_nat
  allocation_id     = element(aws_eip.revive_eip.*.id, count.index)
  connectivity_type = "public"
  subnet_id         = element(aws_subnet.revive_subnet_pub.*.id, count.index)

  tags = merge(var.tags, {
    Name = format("revive-%s-nat-gateway-${count.index + 1}", var.tags["id"])
    }
  )
  depends_on = [aws_internet_gateway.revive_igw]
}

