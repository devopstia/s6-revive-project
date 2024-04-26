resource "aws_ecr_registry_scanning_configuration" "ecr_image_scan" {
  scan_type = var.scan_config["scan_type"]

  rule {
    scan_frequency = var.scan_config["scan_frequency"]
    repository_filter {
      filter      = var.scan_config["filter"]
      filter_type = "WILDCARD"
    }
  }
}