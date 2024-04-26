provider "kubernetes" {
  host                   = data.aws_eks_cluster.revive.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.revive.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.revive.token
}
