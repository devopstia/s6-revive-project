#!/bib/bash
###### This script allow us to destroy all infrastructure provisioned  #######
########  destroy external-dns module ######
echo "destroying external-dns....."
sleep 2
cd ./external-dns
terraform init
terraform destroy --auto-approve
rm -rf .terraform*
########  destroy aws-load-balancer-controller module ######
echo "destroying aws-load-balancer-controller....."
sleep 2
cd ../aws-load-balancer-controller
terraform init
terraform destroy --auto-approve
rm -rf .terraform*
########  destroy aws-ebs-csi-driver module ######
echo "destroying aws-ebs-csi-driver....."
sleep 2
cd ../aws-ebs-csi-driver
terraform init
terraform destroy --auto-approve
rm -rf .terraform*
########  destroy cluster-auto-scaler module ######
echo "destroying cluster-auto-scaler....."
sleep 2
cd ../cluster-auto-scaler
terraform init
terraform destroy --auto-approve
rm -rf .terraform*
########  destroy eks-namespaces module ######
echo "destroying eks-namespaces....."
sleep 2
cd ../eks-namespaces
terraform init
terraform destroy --auto-approve
rm -rf .terraform*
########  destroy aws-auth-config module ######
echo "destroying aws-auth-config....."
sleep 2
cd ../aws-auth-config
terraform init
terraform destroy --auto-approve
rm -rf .terraform*
########  destroy eks-blue-green-node-group module ######
echo "destroying eks-blue-green-node-group....."
sleep 2
cd ../eks-blue-green-node-group
terraform init
terraform destroy --auto-approve
rm -rf .terraform*
########  destroy eks-controlplane module ######
echo "destroying eks-control-plane....."
sleep 2
cd ../eks-control-plane
terraform init
terraform destroy --auto-approve
rm -rf .terraform*