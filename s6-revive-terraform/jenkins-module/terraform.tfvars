region          = "us-east-1"
instance_type   = "t2.medium"
volume_size     = "30"
pub_ip          = true
api_termination = true


tags = {
  "id"            = "1300"
  "Teams"         = "phase5"
  "environment"   = "dev"
  "project"       = "revive"
  "createBy"      = "Terraform"
  "cloudProvider" = "aws"
  "resource"      = "jenkins-master"
}

internal = false

lb_type = "application"

lb_protection = false

desired_capacity = 1
max_size         = 2
min_size         = 1
zone_sub         = "jenkins"
record_type      = "CNAME"
domain_name      = "reviceapp.com"


