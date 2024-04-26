#!/bin/bash

# # Set variables
# KYVERNO_VERSION="v1.5.1" # Change this to the desired version of Kyverno
NAMESPACE="kyverno"

# Define Kyverno policies
echo "Defining Kyverno policies..."

#Adding ecr-revivce secret to all created namespaces
kubectl create -f- << EOF
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: sync-secrets
spec:
  background: false
  rules:
  - name: sync-image-pull-secret
    match:
      any:
      - resources:
          kinds:
          - Namespace
    generate:
      apiVersion: v1
      kind: Secret
      name: ecr-revive
      namespace: "{{request.object.metadata.name}}"
      synchronize: true
      clone:
        namespace: default
        name: ecr-revive
EOF

# Policy to enforce labels on all resources
cat <<EOF | kubectl apply -n $NAMESPACE -f -
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: enforce-resource-labels
spec:
  validationFailureAction: Enforce
  background: false
  rules:
  - name: check-resource-labels
    match:
      resources:
        kinds:
        - Pod
    validate:
      message: "All resources must have labels."
      pattern:
        metadata:
          labels: {}
EOF


# Policy to enforce a specific image pull policy
cat <<EOF | kubectl apply -n $NAMESPACE -f -
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: enforce-image-pull-policy
  labels: 
    APP: image-pull-policy
spec:
  validationFailureAction: Enforce
  background: false
  rules:
  - name: check-image-pull-policy
    match:
      resources:
        kinds:
        - Pod
    validate:
      message: "Image pull policy must be 'Always'."
      pattern:
        spec:
          containers:
          - imagePullPolicy: 'Always'
EOF

# Policy to enforce resource requests and limits
cat <<EOF | kubectl apply -n $NAMESPACE -f -
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: enforce-resource-requests-limits
  labels: 
    APP: enforce-resource-requests-limits
spec:
  validationFailureAction: Enforce
  background: false
  rules:
  - name: check-resource-requests-limits
    match:
      resources:
        kinds:
        - Pod
    validate:
      message: "Pod {{request.object.metadata.name}} must have resource limits defined."
      pattern:
        spec:
          containers:
          - resources:
              limits: {}
              requests: {}
EOF

# Policy to disallow privileged containers
cat <<EOF | kubectl apply -n $NAMESPACE -f -
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-run-as-non-root
spec:
  background: false
  validationFailureAction: Audit
  rules:
  - name: check-containers
    match:
      any:
      - resources:
          kinds:
          - Pod
    validate:
      message: >-
        Running as root is not allowed. The fields spec.securityContext.runAsNonRoot,
        spec.containers[*].securityContext.runAsNonRoot, and
        spec.initContainers[*].securityContext.runAsNonRoot must be `true`.                
      anyPattern:
      # spec.securityContext.runAsNonRoot must be set to true. If containers and/or initContainers exist which declare a securityContext field, those must have runAsNonRoot also set to true.
      - spec:
          securityContext:
            runAsNonRoot: true
          containers:
          - =(securityContext):
              =(runAsNonRoot): true
          =(initContainers):
          - =(securityContext):
              =(runAsNonRoot): true
      # All containers and initContainers must define (not optional) runAsNonRoot=true.
      - spec:
          containers:
          - securityContext:
              runAsNonRoot: true
          =(initContainers):
          - securityContext:
              runAsNonRoot: true

EOF

#Policy to disallow hostPath volumes
cat <<EOF | kubectl apply -n $NAMESPACE -f -
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: disallow-hostpath-volumes
  labels: 
    APP: disallow-hostpath-volumes
spec:
  validationFailureAction: Audit
  background: false
  rules:
  - name: check-hostpath-volumes
    match:
      resources:
        kinds:
        - Pod
    validate:
      message: "HostPath volumes are not allowed."
      pattern:
        spec:
          volumes:
          - hostPath: {}
EOF

# #Policy to disallow hostNetwork
# cat <<EOF | kubectl apply -n $NAMESPACE -f -
# apiVersion: kyverno.io/v1
# kind: ClusterPolicy
# metadata:
#   name: restrict-host-network
# spec:
#   validationFailureAction: Enforce
#   rules:
#   - name: check-host-network
#     match:
#       resources:
#         kinds:
#           - Pod
#     validate:
#       message: "Pod {{request.object.metadata.name}} should not use host network."
#       pattern:
#         spec:
#           hostNetwork: true


# EOF

echo "Kyverno and policies deployed successfully!"
