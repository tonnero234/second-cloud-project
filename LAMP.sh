#!/bin/bash
###################################################
# installation of lamp stack and laravel 
#author: Noah Anthony
#company: Altschool Africa
#Position: cloud engineering student
#Student id= ALT/SOE/023/2141
###################################################
#always update your newly installed linux system before doing any installation
sudo apt update -y
#install your apache2 webserver
sudo apt install apache2 -y
#add the php ondrej repository
sudo add-apt-repository ppa:ondrej/php --yes
#update your repository again so that the newly added ondrej repo would be updated
sudo apt update -y
# install php version 8.2
sudo apt install php8.2 -y
#install some of those php dependencies that are needed for laravel to work, you can check the laravel documentation to see the needed dependencies
sudo apt install php8.2-curl php8.2-dom php8.2-mbstring php8.2-xml php8.2-mysql zip unzip -y
#enable  rewrite which helps us to  manipulate URL requests on the server's side
sudo a2enmod rewrite
#restart your apache server
sudo systemctl restart apache2
#change directory to the bin directory
cd /usr/bin
#install composer that php need to make it easier to manage the libraries in our project by installing and updating them automatically
install composer globally -y
sudo curl -sS https://getcomposer.org/installer | sudo php -q
#move the content of the default composer.phar
sudo mv composer.phar composer
#change directory in /var/www directory so we can clone of laravel repo there
cd /var/www/
#clone the laravel github repository
sudo git clone https://github.com/laravel/laravel.git
sudo chown -R $USER:$USER /var/www/laravel
cd laravel/
install composer autoloader
composer install --optimize-autoloader --no-dev --no-interaction
composer update --no-interaction
#copy the content of the default env file to .env 
sudo cp .env.example .env
sudo chown -R www-data storage
sudo chown -R www-data bootstrap/cache
cd
cd /etc/apache2/sites-available/
sudo touch latest.conf
sudo echo '<VirtualHost *:80>
    ServerName localhost
    DocumentRoot /var/www/laravel/public

    <Directory /var/www/laravel>
        AllowOverride All
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/laravel-error.log
    CustomLog ${APACHE_LOG_DIR}/laravel-access.log combined
</VirtualHost>' | sudo tee /etc/apache2/sites-available/latest.conf
sudo a2ensite latest.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
cd
# we would be installing our mysql server here and perform every steps needed for mysql to run successfully
sudo apt install mysql-server -y
sudo apt install mysql-client -y
sudo systemctl start mysql
sudo mysql -uroot -e "CREATE DATABASE Tinubu;"
sudo mysql -uroot -e "CREATE USER 'shettima'@'localhost' IDENTIFIED BY 'cardoso';"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON Tinubu.* TO 'shettima'@'localhost';"
cd /var/www/laravel
sudo sed -i "23 s/^#//g" /var/www/laravel/.env
sudo sed -i "24 s/^#//g" /var/www/laravel/.env
sudo sed -i "25 s/^#//g" /var/www/laravel/.env
sudo sed -i "26 s/^#//g" /var/www/laravel/.env
sudo sed -i "27 s/^#//g" /var/www/laravel/.env
sudo sed -i '22 s/=sqlite/=mysql/' /var/www/laravel/.env
sudo sed -i '23 s/=127.0.0.1/=localhost/' /var/www/laravel/.env
sudo sed -i '24 s/=3306/=3306/' /var/www/laravel/.env
sudo sed -i '25 s/=laravel/=Tinubu/' /var/www/laravel/.env
sudo sed -i '26 s/=root/=shettima/' /var/www/laravel/.env
sudo sed -i '27 s/=/=cardoso/' /var/www/laravel/.env
sudo php artisan key:generate
sudo php artisan storage:link
sudo php artisan migrate
sudo php artisan db:seed
sudo systemctl restart apache2