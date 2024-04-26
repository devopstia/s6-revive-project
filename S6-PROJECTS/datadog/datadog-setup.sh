#!/bin/bash
######### create secret #############
#######  Adding datadog repo ###########################################
echo "adding datadog repo...."
sleep 5
helm repo add datadog https://helm.datadoghq.com
helm repo update
kubectl create namespace datadog
####### Fetching the helm chart #######################################
echo "fetching datadog helm chart...."
 # Check if the folder datadog exists
 if [ ! -d "datadog" ]; then
     # If it doesn't exist, pull and untar the helm chart
     helm pull --untar datadog/datadog
 fi
# helm fetch --untar datadog/datadog || true
#######   generate over-ride value file ###############################
#######   generate over-ride value file ###############################
cat << EOF > datadog/phase18-values.yaml
datadog:
  clusterName: dev-revive
  apm:
    portEnabled: true
    enabled: true
  logs:
    enabled: true
    containerCollectAll: true
  processAgent:
    processCollection: true
  kubelet:
    tlsVerify: false
  site: us5.datadoghq.com
  clusterAgent:
    replicas: 2
    createPodDisruptionBudget: true
  kubeStateMetricsEnabled: true
  kubeStateMetricsCore:
    enabled: true
  apiKeyExistingSecret: datadog-secret
  prometheusScrape:
    enabled: true
    serviceEndpoints: true
  labelsAsTags:
      web:
        app_name: "ui"
      db:
        app_name: "carts-db"
        app_name: "order-db"
        app_name: "catalog-db"
EOF
###### installing helm chart #########################
 #kubectl create secret generic datadog-secret -n datadog \
 #--from-literal api-key=<>
sleep 5
echo "installing helm chart...."
helm install revive-phase18 -f datadog/phase18-values.yaml \
-n datadog datadog
####################################################