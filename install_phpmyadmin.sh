#!/bin/bash
# Script will auto terminate on errors
set -euo pipefail
IFS=$'\n\t'

# Ubuntu 18.04+, apache2.4, php 7.x
# Run like - bash install_phpmyadmin.sh
# You should have MySQL pre-installed

echo -e "\e[96m Begin silent install phpMyAdmin \e[39m"

echo -e "\e[93m User: root, Password: root \e[39m"
# Set non-interactive mode
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'

sudo apt-get -y install phpmyadmin

# Restart apache server
sudo service apache2 restart

# Clean up
sudo apt-get clean

echo -e "\e[92m phpMyAdmin installed successfully \e[39m"
echo -e "\e[92m Remember: password for root user is root \e[39m"


# sudo mysql -p -u root
# CREATE USER 'itqan'@'localhost' IDENTIFIED BY '123';
# GRANT ALL PRIVILEGES ON *.* TO 'itqan'@'localhost';
# FLUSH PRIVILEGES;


sudo chgrp -R www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+rx {} +
sudo find /var/www/html -type f -exec chmod g+r {} +
sudo chown -R $USER /var/www/html/
sudo find /var/www/html -type d -exec chmod u+rwx {} +
sudo find /var/www/html -type f -exec chmod u+rw {} +