variable "tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "Devops Easy Learning"
    "teams"          = "Phase-10-1"
    "environment"    = "dev"
    "project"        = "revive"
    "create_by"      = "EK-TECH Solutions"
    "cloud_provider" = "aws"
  }
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "aws-load-balancer-controller-sa" {
  type    = string
  default = "aws-load-balancer-controller-sa"
}

variable "aws-load-balancer-controller-ns" {
  type    = string
  default = "kube-system"
}

variable "control_plane_name" {
  type    = string
  default = "dev-revive"
}


