#!/bin/bash
mysql_install_db --user=mysql --ldata=/var/lib/mysql
# mysqld_safe --skip-grant-tables &
mysqld_safe &

mysql -u root < ./entrypoint.sql

pkill mysqld
