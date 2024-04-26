# Install Cluster Autoscaler using HELM

# Resource: Helm Release 
resource "helm_release" "cluster_autoscaler_release" {
  depends_on = [aws_iam_role.cluster-autoscaler]
  name       = var.cluster-autoscaler-ns
  # https://github.com/kubernetes/autoscaler
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  namespace = var.cluster-autoscaler-ns

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = data.aws_eks_cluster.revive.name
  }

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = var.cluster-autoscaler-sa
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.cluster-autoscaler.arn
  }
  set {
    name  = "extraArgs.scale-down-delay-after-add" # time to wait before scaling down after adding a new node
    value = "1m"
  }
  set {
    name  = "extraArgs.scale-down-unneeded-time"  # min time node is underutilized before scaling down
    value = "1m"
  }
  set {
    name  = "fullnameOverride"
    value = "cluster-autoscaler"
  }
}
