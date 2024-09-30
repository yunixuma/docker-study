#!/bin/bash
cd '/usr'
sed -i "/\(bind-address.*$\)/a bind-address            = $WP_DB_HOST" /etc/mysql/mariadb.conf.d/50-server.cnf 
# mysql_install_db --user=mysql --ldata=/var/lib/mysql || mysql_upgrade -u root --password=$MYSQL_ROOT_PASSWORD
mysql_install_db --user=mysql --ldata=/var/lib/mysql
# mysqld_safe --skip-grant-tables &
# mysqld_safe &
/usr/bin/mariadbd-safe --datadir='/var/lib/mysql' &
# service mariadb start

mysql -u root < /entrypoint.sql

# pkill mysqld
# service mariadb stop
