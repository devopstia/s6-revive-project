resource "aws_route_table_association" "revive_public_rt_associate" {
  count          = length(var.availability_zone)
  subnet_id      = element(aws_subnet.revive_subnet_pub.*.id, count.index)
  route_table_id = aws_route_table.revive_public_rt.id
}

resource "aws_route_table_association" "revive_private_rt_associate" {
  count          = length(var.availability_zone)
  subnet_id      = element(aws_subnet.revive_subnet_private.*.id, count.index)
  route_table_id = element(aws_route_table.revive_private_rt.*.id, count.index)
}