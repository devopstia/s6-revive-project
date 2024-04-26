region          = "us-east-1"
instance_type   = "t2.medium"
volume_size     = "30"
pub_ip          = true
api_termination = true
tenancy         = "default"
key             = "bastion-key"


tags = {
  "id"            = "1300"
  "Teams"         = "phase5"
  "environment"   = "dev"
  "project"       = "revive"
  "createBy"      = "Terraform"
  "cloudProvider" = "aws"
  "resource"      = "jenkins-master"
}




