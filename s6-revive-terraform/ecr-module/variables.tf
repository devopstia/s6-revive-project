variable "region" {
  type        = string
  description = "your desire aws region"
  default     = "us-east-1"
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "1800"
    "owner"          = "teamwork"
    "teams"          = "phase5"
    "environment"    = "dev"
    "project"        = "revive"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "ecr_repo_name" {
  type = list(string)
}
variable "scan_on_push" {
  type    = bool
  default = true
}
variable "mutability" {
  type    = string
  default = "MUTABLE"

}

variable "scan_config" {
  type = map(string)
  default = {
    "scan_type"      = "BASIC"
    "scan_frequency" = "SCAN_ON_PUSH"
    "filter"         = "*"
  }
}




