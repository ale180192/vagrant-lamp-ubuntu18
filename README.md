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

# config proxy.

## install nginx
```bash
brew install nginx
```

## remplace nginx.conf file
*   remplace the listen and server_name variables with your configuration
*   remplace the location /app1/ and proxy_pass variables with your configuration
```bash
sudo sed -i '/^/d' /usr/local/etc/nginx/nginx.conf
```
```bash
cat <<EOT >> /etc/apache2/apache2.conf
# Replace /usr/local/etc/nginx/nginx.conf with this. This is the
# default location for Nginx according to 'nginx -h'
worker_processes 1;
error_log /usr/local/var/log/nginx/error.log;

events {
  worker_connections  1024;
}

http {
  # This should be in the same directory as this conf
  # e.g. /usr/local/etc/nginx
  include       mime.types;
  default_type  application/octet-stream;
  
  # Note this log_format is named 'main', and is used with the access log below
  log_format   main '$remote_addr - $remote_user [$time_local]  $status '
    '"$request" $body_bytes_sent "$http_referer" '
    '"$http_user_agent" "$http_x_forwarded_for"';

  sendfile        on;
  keepalive_timeout  65;

  # Without this I got this error: 'upstream sent too big header
  # while reading response header from upstream'
  proxy_buffer_size   128k;
  proxy_buffers   4 256k;
  proxy_busy_buffers_size   256k;

  server {
      listen 80 default_server;
      server_name test.com;
      access_log /usr/local/var/log/nginx/ld3.access.log  main;

      location /app1/ {
          proxy_pass http://192.168.33.10/;
          proxy_ignore_client_abort on;
          proxy_redirect off;
          proxy_set_header Host app1.com;
      }

      location /app2/ {
          proxy_pass http://192.168.33.10/;
          proxy_ignore_client_abort on;
          proxy_redirect off;
          proxy_set_header Host app1.com;
      }

  }
}
EOT
```

## run next command
```bash
sudo launchctl load /Library/LaunchAgents/homebrew.mxcl.nginx.plist
```

### stop and run server
The server must be initializate using sudo command. Validate that no other service is run on the same port listen(by example apache)
```bash
brew services stop nginx
sudo brew services start nginx
```