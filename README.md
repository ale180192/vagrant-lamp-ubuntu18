# vagrant-lamp-ubuntu18
this is a virtual vagrant machine that by provision script it has be installed apache, php7.3, mysql, composer and create databases

download this repository, install vagran of site official and run the next command

```bash
vagran up
```

# support debuging by xdebug. 
* you must install the plugin 'php debug' by Felix Becker. 
* the break points not work, you must use the xdebug_break() funtion for put a break point
* to activate debug mode, go to menu de debug and select start debugging after run from browser the script php.

# php admin

* for use phpadmin only must download the official proyect, unzip, rename to phpadmin, mv to html folder from of this proyect and run on browser localhost/phpadmin
