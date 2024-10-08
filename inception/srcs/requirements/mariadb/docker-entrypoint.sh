#!/bin/bash

PATH_DB=/var/lib/mysql
PATH_LOG=/root/`basename $0 .sh`.log
echo "[`date +"%Y-%m-%d %H:%M:%S"`]\t$0" | tee -a $PATH_LOG

echo "PATH_DB=$PATH_DB" >> $PATH_LOG
echo "PATH_LOG=$PATH_LOG" >> $PATH_LOG
echo "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" >> $PATH_LOG
echo "WP_DB_USER=$WP_DB_USER" >> $PATH_LOG

cd /usr
mysql_install_db --user=mysql --basedir=/usr --datadir=$PATH_DB 2>&1 | tee -a $PATH_LOG \
    || mysql_upgrade -u root --password=$MYSQL_ROOT_PASSWORD 2>&1 | tee -a $PATH_LOG

# mysqld_safe --skip-grant-tables &
# mysqld_safe &
# mariadbd-safe --datadir=$PATH_DB >> PATH_LOG 2>&1 &
service mariadb start

# if [ -f "/root/setup.sql" ]; then
    mysql -u root < /root/setup.sql 2>&1 | tee -a $PATH_LOG
    # rm /root/setup.sql
# fi

pkill mariadbd
# service mariadb stop
# mariadbd-safe -u dbuser --datadir=$PATH_DB 2>&1 | tee -a $PATH_LOG
mariadbd -u $WP_DB_USER --datadir=$PATH_DB 2>&1 | tee -a $PATH_LOG
# tail -f /dev/null
