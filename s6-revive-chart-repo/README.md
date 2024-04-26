### Helm Charts
* This repository is only meant for helm charts for the revive project








![revive](https://github.com/DEL-ORG/s6-terraform-code/assets/96950933/9e6a2443-6cfa-4ab2-bc49-266045418cdc)


### Helm Chart Deployment Guide

This guide provides step-by-step instructions for deploying an application using Helm charts on AWS. The deployment process involves configuring AWS CLI, creating Kubernetes namespaces, setting up image pull secrets, and deploying the application using Helm charts within an Argo project.

### Prerequisites

Before proceeding, ensure you have the following prerequisites:

* [AWS CLI](https://aws.amazon.com/cli/) installed and configured with appropriate access credentials.
* [Kubectl](https://) installed for interacting with your Kubernetes cluster
* [Helm](https://) installed for managing Kubernetes applications.
* [Argo](https://) installed for orchestrating Kubernetes workflows.


### Deployment Steps

1.  ### Configure AWS CLI Credentials
    Ensure your AWS CLI is configured with the necessary access key and secret access key. Run the following command and follow the prompts to set up your credentials:
    
    ```
    aws configure
    ```

2.  ### Create Kubernetes Namespace
    Apply the provided `namespace.yaml` file to create the required namespaces within your Kubernetes cluster. Use the following command:

    ```
    kubectl apply -f namespace.yaml
    ```

3.  ### Set Up Image Pull Secret
    Apply the image pull secret named "ecr-revive" to grant your Kubernetes cluster access to Docker images stored in Amazon ECR. You can use the provided script `image-pull-secret.sh` or manually apply the secret using Kubernetes commands.

    ```
    # Using provided script
    bash image-pull-secret.sh

    # Or manually applying secret
    kubectl apply -f ecr-revive-secret.yaml
    ```

4.  ### Deploy Application Using Helm Charts with Argo
    Execute the deployment script `deploy-helm-charts-with-argo-project.sh` to deploy your application using Helm charts within an Argo project.
    ```
    bash deploy-helm-charts-with-argo-project.sh
    ```

    <br/><br/>

    > Additional-Notes
    > * Review and customize the provided scripts and configurations according to your specific requirements and environment.
    > * Ensure appropriate permissions and prerequisites are set up in your AWS account for successful deployment.
