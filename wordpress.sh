#!/bin/bash

# Update the package repository
sudo yum update -y

# Create /var/www/html directory
#sudo mkdir -p /var/www/html

# Variable for EFS
#EFS_DNS_NAME=fs-0010eb9b6121b2db3.efs.eu-west-2.amazonaws.com

# EFS Mount to the /var/www/html
#sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport "$EFS_DNS_NAME":/ /var/www/html

# Install apache2
sudo yum install git httpd -y

#install php package
#sudo yum install -y epel-release
#sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
#sudo yum-config-manager --enable remi-php81


# Install apache and php dependencies for the php web app
sudo yum install -y \
php81 \
php81-cli \
php81-cgi \
php81-curl \
php81-mbstring \
php81-gd \
php81-mysqlnd \
php81-gettext \
php81-json \
php81-xml \
php81-fpm \
php81-intl \
php81-zip \
php81-bcmath \
php81-ctype \
php81-fileinfo \
php81-openssl \
php81-pdo \
php81-soap \
php81-tokenizer


# Install Mysql-Client 
sudo wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm 
sudo dnf install mysql80-community-release-el9-1.noarch.rpm -y
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023
sudo dnf repolist enabled | grep "mysql.*-community.*"
sudo dnf install -y mysql-community-server 

# Start and enable Apache & Mysql server
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start mysqld
sudo systemctl enable mysqld

# set /var/www/html directory permissions
sudo usermod -aG apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
sudo find /var/www -type f -exec sudo chmod 0664 {} \;
chown apache:apache -R /var/www/html 

# Download Wordpress files and copy to /var/www/html
wget https://wordpress.org/latest.tar.gz
#wget https://wordpress.org/wordpress-4.9.20tar.gz
tar -xzf latest.tar.gz
#tar -xzf wordpress-4.9.20 tar.gz

sudo cp -r wordpress/* /var/www/html/

# create the wp-config.php file
#sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php