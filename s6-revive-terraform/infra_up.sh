#!/bib/bash
###### This script is to install packer, build jenkins master and slave ami, and provision vpc, security group and jenkins master modules #######
########  install packer ######
echo "installing packer....."
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt update && apt install packer
########  build jenkins master ami ######
echo "building jenkins master ami....."
cd packer
packer init jenkins_ami.pkr.hcl
packer build jenkins_ami.pkr.hcl
########  build jenkins slave ami ######
echo "building jenkins slave ami....."
packer init dynamic_ami.pkr.hcl
packer build dynamic_ami.pkr.hcl
########  install vpc module ######
echo "provisioning vpc module....."
sleep 2
cd ../vpc_module
terraform init
terraform apply --auto-approve
########  install security group module ######
echo "provisioning security group module....."
sleep 2
cd ../sg-module
terraform init
terraform apply --auto-approve
########  install jenkins master module ######
echo "provisioning jenkins master module....."
sleep 2
cd ../jenkins-module
terraform init
terraform apply --auto-approve
########  install bastion host ################
echo "provisioning bastion host....."
sleep 2
cd ../bastion-module
terraform init
terraform apply --auto-approve
#################################################