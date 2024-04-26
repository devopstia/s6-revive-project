resource "aws_eip" "revive_eip" {
  count = var.tags["environment"] == "production" ? length(var.availability_zone) : var.num_eip
  vpc   = true

  tags = merge(var.tags, {
    Name = format("revive-%s-eip-${count.index + 1}", var.tags["id"])
    }
  )
}