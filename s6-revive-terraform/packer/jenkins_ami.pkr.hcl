packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "tags" {
  type = map(string)
  default = {
    Name          = "jenkins-master-ami-{{timestamp}}"
    id            = "1300"
    Teams         = "phase5"
    environment   = "dev"
    project       = "revive"
    createBy      = "Terraform"
    cloudProvider = "aws"
    resource      = "jenkins-master"
  }
}

source "amazon-ebs" "jenkins-master" {
  ami_name      = "jenkins-master-ami-{{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  tags = var.tags
  ssh_username = "ubuntu"
}
build {
  name = "jenkins-master-ami-{{timestamp}}"
  sources = [
    "source.amazon-ebs.jenkins-master"
  ]
  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S env {{ .Vars }} {{ .Path }}"
    script          = "master_script.sh"
    pause_before    = "10s"

  }
}