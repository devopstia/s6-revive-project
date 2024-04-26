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
    Name          = "jenkins-slave-ami-{{timestamp}}"
    id            = "1300"
    Teams         = "phase5"
    environment   = "dev"
    project       = "revive"
    createBy      = "Terraform"
    cloudProvider = "aws"
    resource      = "jenkins-master"
  }
}

source "amazon-ebs" "jenkins-slave" {
  ami_name      = "jenkins-slave-ami-{{timestamp}}"
  instance_type = "t2.medium"
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
  ami_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 30
  }
  tags = var.tags
  ssh_username = "ubuntu"
}
build {
  name = "jenkins-slave-ubuntu-20.04"
  sources = [
    "source.amazon-ebs.jenkins-slave"
  ]
  provisioner "file" {
    source      = "users.txt"
    destination = "/tmp/users.txt"
  }
  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S env {{ .Vars }} {{ .Path }}"
    script          = "slave_script.sh"
    pause_before    = "10s"

  }
}