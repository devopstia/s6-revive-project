#!/bin/bash

# # Set variables
# KYVERNO_VERSION="v1.5.1" # Change this to the desired version of Kyverno
NAMESPACE="kyverno"

# Check if the kyverno repo exists, if not, add it
if ! helm repo list | grep -q "kyverno"; then
    helm repo add kyverno https://kyverno.github.io/kyverno/ 
fi

helm repo update

# Check if the folder kyverno exists
if [ ! -d "kyverno" ]; then
    # If it doesn't exist, pull and untar the helm chart
    helm pull --untar kyverno/kyverno
fi

# Create namespace argocd
kubectl create namespace $NAMESPACE

# Helm upgrade argocd
helm upgrade -i kyverno --namespace $NAMESPACE \
    --set admissionController.replicas=3 \
    --set backgroundController.replicas=2 \
    --set cleanupController.replicas=2 \
    --set reportsController.replicas=2 kyverno
