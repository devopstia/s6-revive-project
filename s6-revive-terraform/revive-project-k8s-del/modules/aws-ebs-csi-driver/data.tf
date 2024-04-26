data "aws_eks_cluster" "revive" {
  name = var.control_plane_name
}
data "aws_eks_cluster_auth" "revive" {

  name = var.control_plane_name
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}
