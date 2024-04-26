############ this script installs vault as pod on kubernetes cluster #############
#!/bin/bash
##############  adding hashicorp vault repository ################################
echo "adding hashicorp vault repo...."
sleep 5
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
############ create and switch to namespace ###############
echo "creating and switching to namespace..."
sleep 2
kubectl create ns vault
kubens vault
############# fetching the helm chart ############################################
sleep 5
echo "fetching vault helm chart...."
############ Check if vault chart exists #########################################
 if [ ! -d "vault" ]; then
     # If it doesn't exist, pull and untar the helm chart
     helm pull --untar hashicorp/vault
 fi
############# generate the over-ride value file ###################################
echo "generating over-ride value file...."
sleep 2
cat > vault/vault-values.yaml <<EOF
server:
   affinity: ""
   ha:
      enabled: true
      raft:
         enabled: true
         setNodeId: true
         config: |
            ui = true
            cluster_name = "vault-integrated-storage"
            storage "raft" {
               path    = "/vault/data/"
            }

            listener "tcp" {
               address = "[::]:8200"
               cluster_address = "[::]:8201"
               tls_disable = "true"
            }
            service_registration "kubernetes" {}
ui:
  enabled: true
  serviceType: "LoadBalancer"
  serviceNodePort: null
  externalPort: 8200            
EOF
#################  install the helm chart #########################################
echo "installing the helm chart...."
sleep 2
helm install revive-vault hashicorp/vault -f vault/vault-values.yaml 
################ checking status of the vault server ###############################
echo "checking vault server0 status...."
sleep 60
kubectl exec revive-vault-0 -- vault status
sleep 2
################ initializing vault server #########################################
echo "initializing vault server...."
sleep 20
kubectl exec --stdin=true --tty=true revive-vault-0 -- vault operator init \
    -key-shares=1 \
    -key-threshold=1 \
    -format=json > cluster-keys.json
###############  generate variable for unseal key ##################################
echo "generating variable for unseal key...."
sleep 2
VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")
############### unseal revive-vault-0 ###############################################
echo "unseal first vault server0...."
sleep 60
kubectl exec --stdin=true --tty=true revive-vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY
################ check the status of server0 ###########################################
echo "checking server0 status...."
sleep 60
kubectl exec revive-vault-0 -- vault status
sleep 5
################ getting root token #################################################
echo "getting root token...."
sleep 2
cat cluster-keys.json | jq -r ".root_token"
################ getting cluster root token ########################################
echo "getting cluster token and save in a variable...."
sleep 2
CLUSTER_ROOT_TOKEN=$(cat cluster-keys.json | jq -r ".root_token")
#################  login revive-vault-0 with root token and get connetion string ######
echo "logging in and getting connection string from server0...." 
kubectl exec revive-vault-0 -- vault login $CLUSTER_ROOT_TOKEN
kubectl exec revive-vault-0 -- vault operator raft list-peers
################# join revive-vault-1 to the vault cluster and unseal ##################
echo "joining server1 to clustering and unsealing....."
kubectl exec revive-vault-1 -- vault operator raft join http://revive-vault-0.revive-vault-internal:8200
kubectl exec revive-vault-1 -- vault operator unseal $VAULT_UNSEAL_KEY
################# join revive-vault-2 to the vault cluster and unseal ##################
echo "joining server2 to clustering and unsealing....."
kubectl exec revive-vault-2 -- vault operator raft join http://revive-vault-0.revive-vault-internal:8200
kubectl exec revive-vault-2 -- vault operator unseal $VAULT_UNSEAL_KEY
################## checking clustering ################################################
echo "listing all nodes for revive-vault0...."
kubectl exec revive-vault-0 -- vault operator raft list-peers
sleep 5
echo "ha vault successfully installed...proceed to setting up policies through cli"
####################################################################################



