#!/usr/bin/env bash

apt -y update && apt -y upgrade

# Install Apache2
sudo apt install apache2 -y

# Install PHP
sudo apt install php libapache2-mod-php -y 
sudo apt install php-cli -y
sudo apt install php-cgi -y
sudo apt install php-mysql -y
sudo apt install php-pgsql -y

# Install WordPress
wget https://fr.wordpress.org/wordpress-latest-fr_FR.zip
sudo unzip wordpress-latest-fr_FR.zip -d /var/www
sudo chown www-data:www-data /var/www/wordpress -R
sudo chmod -R -wx,u+rwX,g+rX,o+rX /var/www/wordpress

touch /tmp/cloud-init-ok
