#! /bin/bash
# sudo yum update -y
# sudo yum install httpd -y
# sudo yum install php -y
# sudo yum install php-mysqli -y
# cd /var/www/html/
# sudo wget https://wordpress.org/latest.tar.gz
# tar -zxvf latest.tar.gz
# sudo cp -rf wordpress/* /var/www/html/
# sudo rm -rf wordpress
# sudo rm -rf latest.tar.gz
# sudo chmod -R 755 wp-content/
# sudo chown -R apache:apache wp-content/
# sudo service httpd start
# sudo chkconfig httpd on



#Change these values and keep in safe place
# DB_USER=admin
# DB_PASSWORD=password
# DB_NAME=wordpressdb
# DB_HOST=localhost


sudo yum update -y
sudo yum install httpd -y

# Enable Amazon Linux Extras and install PHP 7.4
sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum install php php-mysqli php-xml php-json php-mbstring php-curl -y

# Change OWNER and permission of directory /var/www
# usermod -a -G apache ec2-user
# chown -R ec2-user:apache /var/www
# find /var/www -type d -exec chmod 2775 {} \;
# find /var/www -type f -exec chmod 0664 {} \;

# Set up WordPress
cd /var/www/html/
sudo wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
sudo cp -rf wordpress/* /var/www/html/
sudo rm -rf wordpress
sudo rm -rf latest.tar.gz
sudo chmod -R 755 wp-content/
sudo chown -R apache:apache wp-content/

# Start and enable Apache
sudo service httpd start
sudo chkconfig httpd on
#cp wp-config-sample.php wp-config.php




#!/bin/bash

# Update system packages
#sudo yum update -y

# Install wp-cli
echo "Installing wp-cli..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp


# Verify installation
echo "Checking wp-cli version..."
wp --version

# Install development tools
sudo yum install -y gcc make

# Install Redis from Amazon Linux Extras repository
sudo amazon-linux-extras install redis6 -y
sudo yum install -y redis

# Start Redis service
sudo systemctl start redis

# Enable Redis to start on boot
sudo systemctl enable redis

# Verify Redis installation
echo "Checking Redis service status..."
sudo systemctl status redis --no-pager

# Install Redis Object Cache (for WordPress, if applicable)
echo "Installing Redis Object Cache plugin..."
#wp plugin install redis-cache --activate
wp plugin install redis-cache --activate --path=/var/www/html

# Enable Redis caching in WordPress (if applicable)
echo "Enabling Redis Object Cache..."
#wp redis enable
wp redis enable --path=/var/www/html
wp redis status

# Confirm Redis is working
echo "Testing Redis connection..."
redis-cli ping

echo "Redis installation and configuration complete."

sudo yum install -y php-pecl-redis
sudo systemctl restart php-fpm

sudo systemctl restart redis
sudo systemctl restart httpd  # For Apache





#!/bin/bash

# Fetch the RDS endpoint from Terraform output
#rds_endpoint=$(terraform output -raw rds_endpoint)
# database_name=$(terraform output -raw database_name)
# db_username=$(terraform output -raw db_username)
# db_password=$(terraform output -raw db_password)

# WordPress database configuration
# db_name="wordpressdb"
# db_user="admin"
# db_password="password"

# # Create the wp-config.php file
# cat <<EOL > /var/www/html/wp-config.php
# <?php
# define('DB_NAME', '${db_name}');
# define('DB_USER', '${db_user}');
# define('DB_PASSWORD', '${db_password}');
# define('DB_HOST', '${rds_endpoint}');
# define('DB_CHARSET', 'utf8');
# define('DB_COLLATE', '');
# \$table_prefix = 'wp_';
# define('WP_DEBUG', false);
# if ( ! defined( 'ABSPATH' ) ) {
#     define( 'ABSPATH', __DIR__ . '/' );
# }
# require_once ABSPATH . 'wp-settings.php';
# ?>
# EOL

# # Set proper permissions
# sudo chmod 640 /var/www/html/wp-config.php
# sudo chown apache:apache /var/www/html/wp-config.php


# cd /var/www/html
# cp wp-config-sample.php wp-config.php

# sed -i "s/wordpress/$db_name/g" wp-config.php
# sed -i "s/username/$db_username/g" wp-config.php
# sed -i "s/password/$db_user_password/g" wp-config.php
# cat <<EOF >>/var/www/html/wp-config.php

# define( 'FS_METHOD', 'direct' );
# define('WP_MEMORY_LIMIT', '256M');
# EOF












#sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Create wordpress configuration file and update database value
# cd /var/www/html
# cp wp-config-sample.php wp-config.php

# sed -i "s/wordpress/$DB_NAME/g" wp-config.php
# sed -i "s/username/$DB_USER/g" wp-config.php
# sed -i "s/host/$DB_HOST/g" wp-config.php
# sed -i "s/password/$DB_PASSWORD/g" wp-config.php
# cat <<EOF >>/var/www/html/wp-config.php

# define( 'FS_METHOD', 'direct' );
# define('WP_MEMORY_LIMIT', '256M');
# EOF




# Create WordPress database and user
# mysql -u root <<EOF
# CREATE DATABASE ${DB_NAME};
# CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
# GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
# FLUSH PRIVILEGES;
# EOF

# echo "Configuring WordPress..."
# cd /var/www/html
# cp wp-config-sample.php wp-config.php
# sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
# sed -i "s/username_here/${DB_USER}/" wp-config.php
# sed -i "s/password_here/${DB_PASSWORD}/" wp-config.php
