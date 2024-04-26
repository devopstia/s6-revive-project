output "cluster_name" {
  # value = "${aws_vpc.main.id}"
  value = aws_eks_cluster.eks.name
}

output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}
# output "controlplane_name" {
#   # value = "${aws_vpc.main.id}"
#   value = aws_eks_cluster.eks.name
# }


# output "controlplane_name" {
#   value = aws_eks_cluster.revive_control.name
# }
# output "cluster_name" {
#   value = aws_eks_cluster.example.name
# }

