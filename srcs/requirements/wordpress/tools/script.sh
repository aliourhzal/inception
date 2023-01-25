#!/bin/bash

mkdir /run/php

if [ ! -f /var/www/wordpress/index.php ]; then
    mkdir /var/www/

    wget https://wordpress.org/latest.zip
    unzip latest.zip
    cp -r wordpress/ /var/www/

    cd /var/www/wordpress
    sed -i "s/username_here/$DB_USER/g" wp-config-sample.php
    sed -i "s/password_here/$DB_USER_PASSWD/g" wp-config-sample.php
    sed -i "s/localhost/mariadb/g" wp-config-sample.php
    sed -i "s/database_name_here/$DB_NAME/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php

    chown -R www-data /var/www/wordpress

    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    wp core install --allow-root --url=$DOMAIN_NAME --title=inception --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWD --admin_email=$WP_ADMIN_EMAIL
    wp user create --allow-root $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWD
fi

/usr/sbin/php-fpm7.4 -F