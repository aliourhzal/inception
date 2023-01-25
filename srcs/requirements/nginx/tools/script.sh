#!/bin/bash

rm /etc/nginx/sites-enabled/default
chown www-data /var/www/html
mkdir /etc/nginx/ssl

nginx -g "daemon off;"