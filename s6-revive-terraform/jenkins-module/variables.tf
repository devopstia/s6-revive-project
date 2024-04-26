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

variable "instance_type" {
  type = string
}

variable "volume_size" {
  type = string
}

variable "api_termination" {
  type = bool
}

variable "pub_ip" {
  type = bool
}

variable "internal" {
  type    = bool
  default = false
}

variable "lb_type" {
  type    = string
  default = "application"
}

variable "lb_protection" {
  type    = bool
  default = true
}

variable "max_size" {
  type    = number
  default = 2
}
variable "min_size" {
  type    = number
  default = 1
}
variable "desired_capacity" {
  type    = number
  default = 1
}

variable "zone_sub" {
  type = string
}

variable "record_type" {
  type = string
}

variable "domain_name" {
  type = string
}

