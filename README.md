# vagrant-lamp-ubuntu18
this is a virtual vagrant machine that by provision script it has be installed apache, php7.3, mysql, composer and create databases

download this repository, install vagran of site official and run the next command

```bash
vagran up
```

TODO: Hacer un virtual host por script con esta funcionalidad
cambiar AllowOverride None por AllowOverride All para permitir usar los .htaccess y reiniciar el servidor
Directory /var/www/>
       Options Indexes FollowSymLinks
       AllowOverride None
       Require all granted
/Directory>