sudo apt update -y
# install mysql
sudo apt install -y mysql-server
mysqld --initialize
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'";
sudo mysql -u root -proot -e "FLUSH PRIVILEGES";
# install apache
sudo apt install -y apache2
sudo ufw allow 'Apache Full'
# inmstall php
sudo apt install -y php libapache2-mod-php php-mysql
sudo systemctl restart apache2
sudo apt install -y curl php-cli php-mbstring git unzip
# modulos apache
sudo a2enmod rewrite
sudo service apache2 reload
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
# create database
mysql -u root -proot -e "create database ld3_telmex character SET utf8 collate utf8_general_ci";
mysql -u root -proot -e "create database ld3_nic character SET utf8 collate utf8_general_ci";
cd /var/www/html
composer install

# cambiar AllowOverride None por AllowOverride All para permitir usar los .htaccess y reiniciar el servidor
# TODO: Hacer un virtual host por script con esta funcionalidad
# sudo nano /etc/apache2/apache2.conf
# sudo systemctl restart apache2
#<Directory /var/www/>
#        Options Indexes FollowSymLinks
#        AllowOverride None
#        Require all granted
#</Directory>

<Directory /var/www/>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
</Directory>