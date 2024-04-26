data "aws_key_pair" "jen_key" {
  key_name           = "jenkins-key"
  include_public_key = true

  filter {
    name   = "tag:env"
    values = ["dev"]
  }
}





