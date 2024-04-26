output "repos" {
  value = aws_ecr_repository.s6_revive_ecr[*]

}
