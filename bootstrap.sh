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
sudo apt install -y php libapache2-mod-php php-mysql php-xdebug php-curl php-xml

#xdebug config
sed -i '/^/d' /etc/php/7.2/apache2/conf.d/20-xdebug.ini
cat <<EOT >> /etc/php/7.2/apache2/conf.d/20-xdebug.ini
zend_extension=/usr/lib/php/20170718/xdebug.so
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.max_nesting_level = 512
xdebug.remote_autostart = true
xdebug.remote_host = 10.0.2.2
xdebug.remote_log = /var/log/xdebug.log
EOT
# config apache server, enable .htaccess files
sed -i '/^/d' /etc/apache2/apache2.conf
cat <<EOT >> /etc/apache2/apache2.conf
DefaultRuntimeDir ${APACHE_RUN_DIR}
PidFile ${APACHE_PID_FILE}
Timeout 300
KeepAlive On
MaxKeepAliveRequests 100
KeepAliveTimeout 5
User ${APACHE_RUN_USER}
Group ${APACHE_RUN_GROUP}
HostnameLookups Off
ErrorLog ${APACHE_LOG_DIR}/error.log
LogLevel warn
# Include module configuration:
IncludeOptional mods-enabled/*.load
IncludeOptional mods-enabled/*.conf
# Include list of ports to listen on
Include ports.conf
<Directory />
        Options FollowSymLinks
        AllowOverride None
        Require all denied
</Directory>
<Directory /usr/share>
        AllowOverride None
        Require all granted
</Directory>

<Directory /var/www/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</Directory>
<VirtualHost *:80>
    ServerName domain1.ld3
    ServerAlias domain1
    SetEnv instance domain1r
</VirtualHost>

<VirtualHost *:80>
    ServerName domain2.ld3
    ServerAlias domain2
    SetEnv instance domain2
</VirtualHost>

<FilesMatch "^\.ht">
        Require all denied
</FilesMatch>
LogFormat "%v:%p %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined
LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %O" common
LogFormat "%{Referer}i -> %U" referer
LogFormat "%{User-agent}i" agent
IncludeOptional conf-enabled/*.conf
IncludeOptional sites-enabled/*.conf
EOT
sudo systemctl restart apache2
sudo apt install -y curl php-cli php-mbstring git unzip
# modulos apache
sudo a2enmod rewrite
sudo service apache2 reload
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
# create database
mysql -u root -proot -e "create database ld3 character SET utf8 collate utf8_general_ci";
cd /var/www/html
composer install

