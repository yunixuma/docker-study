#!/bin/bash

PATH_SITE=/var/www/html
PATH_LOG=/root/`basename $0 .sh`.log
echo "[`date +"%Y-%m-%d %H:%M:%S"`]\t$0" | tee -a $PATH_LOG

echo "PATH_SITE=$PATH_SITE" >> $PATH_LOG
echo "PATH_LOG=$PATH_LOG" >> $PATH_LOG
echo "WP_DB_NAME=$WP_DB_NAME" >> $PATH_LOG
echo "WP_DB_USER=$WP_DB_USER" >> $PATH_LOG
echo "WP_DB_PASSWORD=$WP_DB_PASSWORD" >> $PATH_LOG
echo "WP_DB_HOST=$WP_DB_HOST" >> $PATH_LOG
echo "WP_HOME=$WP_HOME" >> $PATH_LOG
echo "WP_TITLE=$WP_TITLE" >> $PATH_LOG
echo "WP_ADMIN_USER=$WP_ADMIN_USER" >> $PATH_LOG
echo "WP_ADMIN_PASSWORD=$WP_ADMIN_PASSWORD" >> $PATH_LOG
echo "WP_ADMIN_EMAIL=$WP_ADMIN_EMAIL" >> $PATH_LOG
echo "WP_SUB_USER=$WP_SUB_USER" >> $PATH_LOG
echo "WP_SUB_EMAIL=$WP_SUB_EMAIL" >> $PATH_LOG
echo "WP_SUB_PASSWORD=$WP_SUB_PASSWORD" >> $PATH_LOG

cd $PATH_SITE
# ls wp-login.php
if [ ! -f "wp-login.php" ]; then
	chmod 755 ./ 2>&1 | tee -a $PATH_LOG
	# mysql -u $WP_DB_USER --password=$WP_DB_PASSWORD --host $WP_DB_HOST --connect-timeout 300
	wp core download --path="$PATH_SITE" --allow-root 2>&1 | tee -a $PATH_LOG
	wp core config --dbname="$WP_DB_NAME" --$WP_DB_USER="$WP_DB_USER" --dbpass="$WP_DB_PASSWORD" \
		--dbhost="$WP_DB_HOST" --path="$PATH_SITE" --allow-root 2>&1 | tee -a $PATH_LOG
	wp core install --url="http://$WP_HOME/" --title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" \
		--path="$PATH_SITE" --allow-root 2>&1 | tee -a $PATH_LOG
	wp user create "$WP_SUB_USER" "$WP_SUB_EMAIL" --role=author --user_pass="$WP_SUB_PASSWORD" \
		--allow-root 2>&1 | tee -a $PATH_LOG
	# wp plugin install --activate --allow-root
	rm -f index.htm* 2>&1 | tee -a $PATH_LOG
	chown -R www-data:www-data ./ 2>&1 | tee -a $PATH_LOG
	find ./ -type d -exec chmod 755 {} + 2>&1 | tee -a $PATH_LOG
	find ./ -type f -exec chmod 644 {} + 2>&1 | tee -a $PATH_LOG
fi

# php -S 0.0.0.0:443 -t $PATH_SITE 2>&1 | tee -a $PATH_LOG &
php-fpm7.4 -F 2>&1 | tee -a $PATH_LOG
# tail -f /dev/null
