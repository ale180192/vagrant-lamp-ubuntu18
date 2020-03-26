# vagrant-lamp-ubuntu18
this is a virtual vagrant machine that by provision script it has be installed apache, php7.3, mysql, composer and create databases

download this repository, install vagran of site official and run the next command

```bash
vagran up
```

# support debugging by xdebug. 
* you must install the plugin 'php debug' by Felix Becker. 
* the break points not work, you must use the xdebug_break() funtion for put a break point
* to activate debug mode, go to menu de debug and select start debugging after run from browser the script php.

edit to ./vscode/launch.jso file
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "pathMappings": {
                "/var/www/html": "${workspaceFolder}"
            },
            "port": 9000,
            "log": true,
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch",
            "program": "${file}",
            "cwd": "${fileDirname}",
            "port": 9000
        }
    ]
}
```

# php admin

* for use phpadmin only must download the official project, unzip, rename to phpadmin, move to html folder of this project and run on browser localhost/phpadmin
* user and password are root for both