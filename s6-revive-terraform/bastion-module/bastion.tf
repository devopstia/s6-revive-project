resource "aws_instance" "revive_bastion" {
  ami                         = data.aws_ami.bastion_ami.id
  instance_type               = var.instance_type
  key_name                    = var.key
  tenancy                     = var.tenancy
  associate_public_ip_address = var.pub_ip
  vpc_security_group_ids      = [data.aws_security_group.bastion_sg.id]
  subnet_id                   = data.aws_subnet.bastion_sub_pub.id
  disable_api_termination     = var.api_termination


  root_block_device {
    volume_size = var.volume_size
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = merge(var.tags, {
    Name = format("bastion-%s-revive", var.tags["id"])
  })

}