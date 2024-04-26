terraform {
  backend "s3" {
    bucket         = "s6-revive-terraform"
    dynamodb_table = "revive-k8s-tfstate-locking"
    key            = "bastion/terraform.tf"
    region         = "us-east-1"
  }
}