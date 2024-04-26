data "aws_eks_cluster" "revive" {

  # name = "dev-revive"
  name = var.control_plane_name
}

data "aws_eks_cluster_auth" "revive" {

  # name = "dev-revive"
  name = var.control_plane_name
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}
