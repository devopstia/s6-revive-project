resource "aws_ecr_repository" "s6_revive_ecr" {
  for_each             = toset(var.ecr_repo_name)
  name                 = each.key
  image_tag_mutability = var.mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

}