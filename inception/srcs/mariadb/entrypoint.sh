#!/bin/bash
mysql_install_db --user=mysql --ldata=/var/lib/mysql
# mysqld_safe --skip-grant-tables &
mysqld_safe &

# mysql -u root; 
# truncate table user;
# flush privileges;
# grant all privileges on *.* to root@localhost identified by '$MYSQL_ROOT_PASSWORD' with grant option;
# flush privileges;
# # quit;
mysql -u root;
ALTER USER 'root'@'$WP_DB_HOST' IDENTIFIED BY $MYSQL_ROOT_PASSWORD;
# SET PASSWORD = $MYSQL_ROOT_PASSWORD;
CREATE DATABASE $WP_DB_NAME;
CREATE USER '$WP_DB_USER'@'$WP_DB_HOST' IDENTIFIED BY '$WP_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'$WP_DB_HOST';
quit;

pkill mysqld
