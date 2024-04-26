variable "name_spaces" {
  type = list(string)
}

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

variable "control_plane_name" {
  type    = string
  default = "dev-revive"
}
