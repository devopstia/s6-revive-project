###############  create a file with the content under service_account.yaml and apply ############
kubectl apply -f service_account.yaml
############## putting access tokens in a variable ##############################################
    TOKEN_REVIEW_JWT=$(kubectl get secret vault-auth --output='go-template={{ .data.token }}' | base64 --decode) 
    KUBE_CA_CERT=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.certificate-authority-data}' | base64 --decode) 
    KUBE_HOST=$(kubectl config view --raw --minify --flatten --output='jsonpath={.clusters[].cluster.server}')
############## login to first vault server #######################################################
kubectl exec --stdin=true --tty=true revive-vault-0 -n vault -- /bin/sh
###############  enable vault secret engine setting a path in the engine #########################
vault secrets enable -path=kvv2 kv-v2
############### create a secret record on the engine #############################################
vault kv put kvv2/webapp username="web-user" password=":pa55word:"
############### create access policy for the engine ##############################################
vault policy write revive-app - <<EOF
path "kvv2/*" {
  capabilities = ["read", "list"]
}
EOF
############## set the mode of authentication to vault from the cluster #########################
vault auth enable -path=vso kubernetes
#############  configure the authentication #####################################################
vault write auth/vso/config \
      token_reviewer_jwt="$TOKEN_REVIEW_JWT" \
      kubernetes_host="$KUBE_HOST" \
      kubernetes_ca_cert="$KUBE_CA_CERT" \
      disable_issuer_verification=true
vault write auth/vso/role/vso-role \
      bound_service_account_names=revive \
      bound_service_account_namespaces=revive \
      policies=revive-app \
      ttl=24h
exit