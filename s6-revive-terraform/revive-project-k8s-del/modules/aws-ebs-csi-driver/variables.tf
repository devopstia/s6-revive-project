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

variable "aws-ebs-csi-driver-sa" {
  type    = string
  default = "aws-ebs-csi-driver-sa"
}

variable "aws-ebs-csi-driver-ns" {
  type    = string
  default = "aws-ebs-csi-driver"
}

variable "control_plane_name" {
  type    = string
  default = "dev-revive"
}

variable "storage-class-name" {
  type    = string
  default = "dev-revive"
}

