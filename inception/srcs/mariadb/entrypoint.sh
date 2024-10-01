#!/bin/bash
# mkdir -p /var/lib/mysql
# chown -hR 101:101 /var/lib/mysql
# chmod 777 -R /var/lib/mysql/

PATH_DB=/var/lib/mysql
PATH_LOG=~/entrypoint.log

cd /usr
mysql_install_db --user=mysql --basedir=/usr --datadir=$PATH_DB >> $PATH_LOG 2>&1 \
    || mysql_upgrade -u root --password=$MYSQL_ROOT_PASSWORD >> $PATH_LOG 2>&1

# mysqld_safe --skip-grant-tables &
# mysqld_safe &
# mariadbd-safe --datadir=$PATH_DB >> PATH_LOG 2>&1 &
service mariadb start

mysql -u root < /root/setup.sql >> $PATH_LOG 2>&1

# pkill mysqld
# service mariadb stop
tail -f /dev/null
