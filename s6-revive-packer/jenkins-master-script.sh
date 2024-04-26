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

function jenkins_installation {
    sudo apt update
    ## Set vim as default text editor
    sudo update-alternatives --set editor /usr/bin/vim.basic
    sudo update-alternatives --set vi /usr/bin/vim.basic
    sudo apt install fontconfig openjdk-17-jre -y
    java -version
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins -y
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
}


if [[ $OS_NAME == "Red Hat Enterprise Linux" ]] || [[ $OS_NAME == "CentOS Linux" ]] || [[ $OS_NAME == "Amazon Linux" ]] 
then
    yum_os
elif [[ $OS_NAME == "Ubuntu" ]] 
then
    apt_os
    jenkins_installation
else
    echo "HUMMMMMMMMMM. I don't know this OS"
    exit
fi