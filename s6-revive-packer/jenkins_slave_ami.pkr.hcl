packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "jenkins-slave" {
  ami_name      = "jenkins-slave-ubuntu-20.04"
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
    script          = "jenkins-slave-script.sh"
    pause_before    = "10s"

  }

}