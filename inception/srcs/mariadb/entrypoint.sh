#!/bin/bash
# mkdir -p /var/lib/mysql
# chown -hR 101:101 /var/lib/mysql
# chmod 755 -R /var/lib/mysql/

PATH_DB=/var/lib/mysql
PATH_LOG=~/entrypoint.log
echo "[`date +"%Y-%m-%d %H:%M:%S"`]\t$0" >> $PATH_LOG

echo "PATH_DB=$PATH_DB" >> $PATH_LOG
echo "PATH_LOG=$PATH_LOG" >> $PATH_LOG
echo "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" >> $PATH_LOG

cd /usr
mysql_install_db --user=mysql --basedir=/usr --datadir=$PATH_DB >> $PATH_LOG 2>&1 \
    || mysql_upgrade -u root --password=$MYSQL_ROOT_PASSWORD >> $PATH_LOG 2>&1

# mysqld_safe --skip-grant-tables &
# mysqld_safe &
mariadbd-safe --datadir=$PATH_DB >> PATH_LOG 2>&1 &
# service mariadb start

if [ -f "/root/setup.sql" ]; then
    mysql -u root < /root/setup.sql >> $PATH_LOG 2>&1
    rm /root/setup.sql
fi

pkill mariadbd
# service mariadb stop
# tail -f /dev/null
mariadbd-safe --datadir=$PATH_DB >> PATH_LOG 2>&1
