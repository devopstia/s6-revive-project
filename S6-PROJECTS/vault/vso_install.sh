############ this script installs vault secret operator on kubernetes cluster #############
#!/bin/bash
##############  adding hashicorp vault repository ################################
echo "adding hashicorp vault repo...."
sleep 5
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
############ create and switch to namespace ###############
echo "switching to namespace..."
sleep 2
kubens vault
############# fetching the helm chart ############################################
sleep 5
echo "fetching vault helm chart...."
############ Check if vault secret operator chart exists #########################################
 if [ ! -d "vault-secrets-operator" ]; then
     # If it doesn't exist, pull and untar the helm chart
     helm pull --untar hashicorp/vault-secrets-operator
 fi
#################  install the helm chart #########################################
echo "installing the helm chart...."
sleep 2
helm install revive-vault hashicorp/vault-secrets-operator  