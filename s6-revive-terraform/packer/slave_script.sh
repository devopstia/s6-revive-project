#!/bin/bash

###### Get the OS of the machine ################################################
OS_NAME=$(cat /etc/*release |grep -w NAME |awk -F'"' '{print$2}')

################   function to be executed if $OS_NAME=centos ###################
function yum_os {
  echo "This is $OS_NAME OS"
  sleep 5
  yum update -y 
}

################  function to be executed if $OS_NAME=ubuntu #####################
function apt_os {
    echo "This is $OS_NAME OS"
    sleep 5
    ####### List of packages to install ########################################
    packages=(
        curl      
        wget
        apt-utils
        vim
        openssh-client
        openssh-server
        python3
        nodejs
        build-essential
        npm
        ansible
        htop
        watch
        pip3 
        git 
        make
        psql  
        python3-pip 
        openssl 
        rsync 
        jq 
        postgresql-client 
        mariadb-client 
        mysql-client 
        unzip 
        tree 
        default-jdk
        default-jre
        maven
        gnupg
        software-properties-common
    )

    # Update package list
    sudo apt update -y
    sudo apt upgrade -y
    # Install packages
    for package in "${packages[@]}"; do
        echo "Installing $package Please wait ................."
        sleep 3
        sudo DEBIAN_FRONTEND=noninteractive apt install -y "$package"
    done
    echo "Package installation completed."
}

function apt_software {
    ## Install aws cli
    which aws
    if [ "$?" -eq 0 ]; then
        echo "AWS ClI is intalled already. Noting to do"
    else
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        rm -rf awscliv2.zip
        rm -rf aws
    fi

    # Install Terrafrom on Ubuntu Machine
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform

    # Install Ansible
    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible

    ## Install grype
    ## https://github.com/anchore/grype/releases
    GRYPE_VERSION="0.66.0"
    wget https://github.com/anchore/grype/releases/download/v${GRYPE_VERSION}/grype_${GRYPE_VERSION}_linux_amd64.tar.gz
    tar -xzf grype_${GRYPE_VERSION}_linux_amd64.tar.gz
    chmod +x grype
    sudo mv grype /usr/local/bin/
    grype version

    ## Install Gradle
    ## https://gradle.org/releases/
    GRADLE_VERSION="4.10"
    sudo apt install openjdk-11-jdk -y
    wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
    unzip gradle-${GRADLE_VERSION}-bin.zip
    mv gradle-${GRADLE_VERSION} /opt/gradle-${GRADLE_VERSION}
    /opt/gradle-${GRADLE_VERSION}/bin/gradle --version

    ## Install kubectl
    sudo curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl 
    sudo chmod +x ./kubectl 
    sudo mv kubectl /usr/local/bin/

    ## INSTALL KUBECTX AND KUBENS
    sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx 
    sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens 
    sudo chmod +x kubectx kubens 
    sudo mv kubens kubectx /usr/local/bin

    ## Install Helm 3
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    sudo  chmod 700 get_helm.sh
    sudo ./get_helm.sh
    sudo helm version

    ## Install Docker Coompose
    # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version

    ### TERRAGRUNT INSTALLATIN
    # https://terragrunt.gruntwork.io/docs/getting-started/supported-terraform-versions/
    TERRAGRUNT_VERSION="v0.38.0"
    sudo wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 
    sudo mv terragrunt_linux_amd64 terragrunt 
    sudo chmod u+x terragrunt 
    sudo mv terragrunt /usr/local/bin/terragrunt
    terragrunt --version

    ## Install Packer
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install packer
    packer --version

    ## Install trivy
    sudo apt-get -y update
    sudo apt-get install wget apt-transport-https
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
    echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
    sudo apt-get -y update
    sudo apt-get install trivy -y

    ## Install ArgoCD agent
    wget https://github.com/argoproj/argo-cd/releases/download/v2.8.5/argocd-linux-amd64
    chmod +x argocd-linux-amd64
    sudo mv argocd-linux-amd64 /usr/local/bin/argocd
    argocd version

    ## Install Docker
    # https://docs.docker.com/engine/install/ubuntu/
    sudo apt-get remove docker docker-engine docker.io containerd runc -y
    sudo apt-get update
    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    sudo apt-get update
    sudo apt install docker-ce docker-ce-cli containerd.io -y
    sudo systemctl start docker
    sudo systemctl enable docker

    ## chmod the Docker socket. the Docker daemon does not have the necessary permissions to access the Docker socket file located at /var/run/docker.sock
    sudo chown root:docker /var/run/docker.sock
    sudo chmod -R 666 /var/run/docker.sock
}

function user_setup {
    username=$(cat /tmp/users.txt | tr '[A-Z]' '[a-z]')
    GROUP_NAME="tools"

    # cat /etc/group |grep -w tools &>/dev/nul || sudo groupadd $GROUP_NAME

    if grep -q "^$GROUP_NAME:" /etc/group; then
        echo "Group '$GROUP_NAME' already exists."
    else
        sudo groupadd "$GROUP_NAME"
        echo "Group '$GROUP_NAME' created."
    fi

    if sudo grep -q "^%$GROUP_NAME" /etc/sudoers; then
        echo "Group '$GROUP_NAME' is already in sudoers."
    else
        echo "%$GROUP_NAME ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
        echo "Group '$GROUP_NAME' added to sudoers with NOPASSWD: ALL."
    fi

    ## allow automation tools to access docker
    for i in $username
    do 
        if grep -q "^$i" /etc/sudoers; then
            echo "User '$i' is already in sudoers."
        else
            echo "$i ALL=(ALL) NOPASSWD: /usr/bin/docker" | sudo tee -a /etc/sudoers
        fi
    done
    for users in $username
    do
        ls /home |grep -w $users &>/dev/nul || mkdir -p /home/$users
        cat /etc/passwd |awk -F: '{print$1}' |grep -w $users &>/dev/nul ||  useradd $users
        sudo chown -R $users:$users /home/$users
        sudo usermod -s /bin/bash -aG tools $users
        sudo usermod -s /bin/bash -aG docker $users
        sudo usermod -aG docker root
        echo -e "$users\n$users" |passwd "$users"
    done

    ## Set vim as default text editor
    sudo update-alternatives --set editor /usr/bin/vim.basic
    sudo update-alternatives --set vi /usr/bin/vim.basic
}

function enable_password_authentication {
    # Check if password authentication is already enabled
    if grep -q "PasswordAuthentication yes" /etc/ssh/sshd_config; then
        echo "Password authentication is already enabled."
    else
        # Enable password authentication by modifying the SSH configuration file
        sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
        echo "Password authentication has been enabled in /etc/ssh/sshd_config."

        # Restart the SSH service to apply changes
        sudo systemctl restart ssh
        echo "SSH service has been restarted."
    fi
}

if [[ $OS_NAME == "Red Hat Enterprise Linux" ]] || [[ $OS_NAME == "CentOS Linux" ]] || [[ $OS_NAME == "Amazon Linux" ]] 
then
    yum_os
elif [[ $OS_NAME == "Ubuntu" ]] 
then
    apt_os
    apt_software
    user_setup
    enable_password_authentication
else
    echo "HUMMMMMMMMMM. I don't know this OS"
    exit
fi