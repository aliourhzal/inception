#!/bin/bash

echo "CREATE DATABASE IF NOT EXISTS wordpress;" > db.sql
echo "CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wpuser' ;" >> db.sql
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%' ;" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

service mariadb start

mysql < db.sql