#!/bin/bash

#Update linux server repository
sudo apt update -y

#Install apache webserver
sudo apt install apache2 -y

#Add the php ondrej repository
sudo add-apt-repository ppa:ondrej/php --yes

#Update your server repository again
sudo apt update -y

#Install php8.2
sudo apt install php8.2 -y

#Install php dependencies required for laravel to work
sudo apt install php8.2-curl php8.2-dom php8.2-mbstring php8.2-xml php8.2-mysql zip unzip -y

#Enable rewrite
sudo a2enmod rewrite

#Restart your apache server
sudo systemctl restart apache2

#Change directory in the bin directory and install composer
cd /usr/bin
install composer globally -y
sudo curl -sS https://getcomposer.org/installer | sudo php -q

#Move the content of the deafault composer.phar
sudo mv composer.phar composer
cd
#Change directory to /var/www directory and clone of laravel repo there
cd /var/www/
sudo git clone https://github.com/laravel/laravel.git
sudo chown -R $USER:$USER /var/www/laravel

#cd into laravel directory and install composer dependencies
cd laravel/
install composer autoloader
composer install --optimize-autoloader --no-dev --no-interaction
composer update --no-interaction

#Copy the content of the default env file to .env
sudo cp .env.example .env
sudo chown -R www-data storage
sudo chown -R www-data bootstrap/cache

#cd into apache sites-available folder and configure your server
cd
cd /etc/apache2/sites-available/
sudo touch new.conf
sudo echo '<VirtualHost *:80>
    ServerName localhost
    DocumentRoot /var/www/laravel/public

    <Directory /var/www/laravel>
        AllowOverride All
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/laravel-error.log
    CustomLog ${APACHE_LOG_DIR}/laravel-access.log combined
</VirtualHost>' | sudo tee /etc/apache2/sites-available/new.conf

#Enable your new configuration and disable default configuration, then restart apache
sudo a2ensite new.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2

#Install mysql and create database
cd
sudo apt install mysql-server -y
sudo apt install mysql-client -y
sudo systemctl start mysql
sudo mysql -uroot -e "CREATE DATABASE Kelechi;"
sudo mysql -uroot -e "CREATE USER 'kaycee'@'localhost' IDENTIFIED BY 'kayceecross';"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON Kelechi.* TO 'kaycee'@'localhost';"

#cd into /laravel directory and use sed command to edit database file
cd /var/www/laravel
sudo sed -i "23 s/^#//g" /var/www/laravel/.env
sudo sed -i "24 s/^#//g" /var/www/laravel/.env
sudo sed -i "25 s/^#//g" /var/www/laravel/.env
sudo sed -i "26 s/^#//g" /var/www/laravel/.env
sudo sed -i "27 s/^#//g" /var/www/laravel/.env
sudo sed -i '22 s/=sqlite/=mysql/' /var/www/laravel/.env
sudo sed -i '23 s/=127.0.0.1/=localhost/' /var/www/laravel/.env
sudo sed -i '24 s/=3306/=3306/' /var/www/laravel/.env
sudo sed -i '25 s/=laravel/=Kelechi/' /var/www/laravel/.env
sudo sed -i '26 s/=root/=kaycee/' /var/www/laravel/.env
sudo sed -i '27 s/=/=kayceecross/' /var/www/laravel/.env

#Generate app_key value
sudo php artisan key:generate

#Create symbolic link
sudo php artisan storage:link

#Run migration
sudo php artisan migrate

#Populate database with dummy content using seed command
sudo php artisan db:seed

#Restart apache service
sudo systemctl restart apache2
