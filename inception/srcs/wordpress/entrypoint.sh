#!/bin/bash
PATH_CONF='/etc/php/7.4/fpm/pool.d/www.conf'
sed -i "s/\/run\/php\/php7.4-fpm.sock/nginx:9000/" $PATH_CONF
cd /var/www/html
# mysql -u $WP_DB_USER --password=$WP_DB_PASSWORD --host $WP_DB_HOST --connect-timeout 300
wp core download --path="/var/www/html" --allow-root
wp core config --dbname="$WP_DB_NAME" --dbuser="$WP_DB_USER" --dbpass="$WP_DB_PASSWORD" --dbhost="$WP_DB_HOST" --path="/var/www/html" --allow-root
wp core install --url="http://$WP_HOME/" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="/var/www/html" --allow-root
wp user create "$WP_SUB_USER" "$WP_SUB_EMAIL" --role=subscriber --user_pass="$WP_SUB_PASSWORD" --allow-root
# wp plugin install --activate --allow-root
