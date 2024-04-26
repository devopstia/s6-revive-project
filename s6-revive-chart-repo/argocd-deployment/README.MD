
1- Research on how argocd function 

2- Deploy argocd as IaC
        a- create users (s6student, peter, raoul, confidence, prince bridget christopher)

        b- create a project call revive 

        c- create a repo  with git@github.com:DEL-ORG/s6-revive-chart-repo.git, the helm chart is private so make sure to login with ssh
       d- restict this repo only to the project revive

main steps:
1. get the cm and add user account 
2. use the script and create a password for each user on cli
3. get the use the argocd-rback-cm and create a policy for each user

dZXa9xtlWsFc2Qwz
192.168.49.2:30080

---- kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}' 
--- kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d


#add password
kubectl patch -n argocd secret argocd-secret --type='json' -p='[{"op": "add", "path": "/data/accounts.alice.password", "value": "cGV0ZXIxMjM0"}]'

echo -n 'peter1234' | base64

#restart service deployment
kubectl rollout restart deployment argocd-server -n argocd


#login as admin
argocd login 192.168.49.2:30080 --username admin --password peter1234 --insecure


#set password for user
# if you are managing users as the admin user, <current-user-password> should be the current admin password.
argocd account update-password \
  --account peter \
  --current-password peter1234 \
  --new-password peter123



#################################################################################################

INSTALLING ARGOCD 
kubectl create namespace argocd 

# Create a namespace
kubectl create namespace argocd

# Add the ArgoCD Helm Chart
helm repo add argo https://argoproj.github.io/argo-helm

#helm repo list , helm search repo 

#download local copy
helm pull --untar argo/argo-cd 

# Install the ArgoCD local copy
helm upgrade -i argocd --namespace argocd --set redis.exporter.enabled=true --set redis.metrics.enabled=true --set server.metrics.enabled=true --set controller.metrics.enabled=true argo-cd

# Install the ArgoCD- repocomy
helm upgrade -i argocd --namespace argocd --set redis.exporter.enabled=true --set redis.metrics.enabled=true --set server.metrics.enabled=true --set controller.metrics.enabled=true argo/argo-cd

# Check the status of the pods
kubectl get pods -n argocd




types of users
 - local users 
 
 Local users/accounts¶
The local users/accounts feature serves two main use-cases:

-- Auth tokens for Argo CD management automation. It is possible to configure an API account with limited permissions and generate an authentication token. Such token can be used to automatically create applications, projects etc.

-- users for a very small team where use of SSO integration might be considered an overkill.
-- The local users don't provide advanced features such as groups, login history etc. 
So if you need such features it is strongly recommended to use SSO.

 - SSO integration  users 



