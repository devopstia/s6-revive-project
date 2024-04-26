# resource "aws_key_pair" "node_group_key" {
#   key_name   = var.ec2_ssh_key
#   public_key = tls_private_key.node_group_key.public_key_openssh
# }

# resource "local_file" "node_group_key" {
#   content  = tls_private_key.node_group_key.private_key_pem
#   filename = "node_group_key"
# }
# resource "tls_private_key" "node_group_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }