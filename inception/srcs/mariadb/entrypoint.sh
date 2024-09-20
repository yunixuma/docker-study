#!/bin/bash
# mysqld_safe --skip-grant-tables &
mysqld_safe &
mysql_install_db --user=mysql --ldata=/var/lib/mysql

mysql -u root; 
truncate table user;
flush privileges;
grant all privileges on *.* to root@localhost identified by '$WP_ADMIN_PASSWORD' with grant option;
flush privileges;
# quit;
# mysql -u root;
# ALTER USER 'root'@'localhost' IDENTIFIED BY $WP_ADMIN_PASSWORD;
# SET PASSWORD = $WP_ADMIN_PASSWORD;
CREATE DATABASE $WP_DB_NAME;
CREATE USER '$WP_DB_USER'@'$DB_HOST' IDENTIFIED BY '$WP_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'$WP_DB_HOST';
quit;

pkill mysqld
