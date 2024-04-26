variable "region" {
  type    = string
  default = "us-east-1"
}

variable "tags" {
  type = map(string)
  default = {
    "id"            = "1300"
    "Teams"         = "phase5"
    "environment"   = "dev"
    "project"       = "revive"
    "createBy"      = "Terraform"
    "cloudProvider" = "aws"
    "resource"      = "jenkins-master"
  }
}

variable "ports" {
  type = list(number)
  default = [
    22,
    80,
    8080,
    443
  ]
}
     