
#!/bin/bash
# Update package lists
sudo apt-get update -y

# Install Java
#sudo apt install openjdk-11-jre-headless -y
#sudo java --version

#install git
sudo apt install git -y
git --version

#install docker
sudo apt install docker.io -y
sudo systemctl start docker
sudo docker run hello-world
sudo systemctl enable docker
docker --version
sudo usermod -a -G docker $(whoami)
sudo chmod 777 /var/run/docker.sock
sudo systemctl restart docker



# Install nginx
# Use this for your user data (script from the top to bottom)
#install apache2 (ubuntu version)
# sudo apt update -y
# sudo apt install -y nginx
# sudo service nginx start
# sudo systemctl enable nginx
#echo "<h1>Hello World from Raymond Ogbebor. Learning terraform from this instance $(hostname -f)</h1>" > /var/www/html/index.html


sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update 
sudo apt install jenkins 
sudo jenkins --version
sudo systemctl enable jenkins
sudo systemctl start jenkins


#Install Ansible
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt upgrade -y
sudo apt install ansible -y



#install Jenkins

# sudo apt-get update -y
# sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
# echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
#   /etc/apt/sources.list.d/jenkins.list > /dev/null -y
# sudo apt-get install -y jenkins
# sudo jenkins --version
# sudo systemctl enable jenkins
# sudo systemctl start jenkins




#clone the git
#sudo cd /
#sudo cd /var/www/html/
#sudo git clone https://github.com/sujoyduttajad/Landing-Page-React.git
#sudo git clone https://github.com/gabrielecirulli/2048.git
#sudo rm index.nginx-debian.html
#cd Landing-Page-React/
#cp -r * /var/www/html/


# install nvm
# sudo su -
# sudo apt-get update -y
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash -y
# . ~/.nvm/nvm.sh -y
# nvm install 16.0.0 -y 
# node -e "console.log('Running Node.js ' + process.version)" -y
# git clone https://github.com/raymondogbe/Landing-Page-React.git -y
# cd Landing-Page-React/
# npm install -y
# npm start -y



#sudo vi /etc/sudoers
#jenkins ALL=(ALL) NOPASSWD: ALL 
#sudo usermod -aG docker jenkins 
#sudo su - jenkins


# sudo apt install awscli
# sudo apt install curl unzip
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install
# aws configure

#kubectl
# curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.3/2024-04-19/bin/linux/amd64/kubectl
#chmod +x ./kubectl
#sudo mv ./kubectl /usr/local/bin

#eksctl
#curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
#sudo mv /tmp/eksctl /usr/local/bin

#aws eks update-kubeconfig --name erply --region us-west-1

#eksctl create cluster --name erply-test-cluster --version 1.29 --region us-west-1 --nodegroup-name worker-nodes --node-type t2.small --nodes 2


/*
#######################################################################################################################################
#From the Devops handson

#!/bin/bash
# For Ubuntu 22.04
# Intsalling Java
sudo apt update -y
sudo apt install openjdk-17-jre -y
sudo apt install openjdk-17-jdk -y
java --version

# Installing Jenkins
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y

# Installing Docker 
#!/bin/bash
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
sudo chmod 777 /var/run/docker.sock

# If you don't want to install Jenkins, you can create a container of Jenkins
# docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-container jenkins/jenkins:lts

# Run Docker Container of Sonarqube
#!/bin/bash
docker run -d  --name sonar -p 9000:9000 sonarqube:lts-community


# Installing AWS CLI
#!/bin/bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# Installing Kubectl
#!/bin/bash
sudo apt update
sudo apt install curl -y
sudo curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client


# Installing eksctl
#! /bin/bash
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# Installing Terraform
#!/bin/bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform -y

# Installing Trivy
#!/bin/bash
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update
sudo apt install trivy -y


# Intalling Helm
#! /bin/bash
sudo snap install helm --classic


##############################################################################################################################
*/