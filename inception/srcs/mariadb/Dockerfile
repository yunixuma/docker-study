## Pull the base image
FROM debian:bullseye-slim
# FROM debian:bullseye

## Args for building the image
ARG MYSQL_ADMIN_PASSWORD=$MYSQL_ADMIN_PASSWORD
ARG WP_DB_NAME=$WP_DB_NAME
ARG WP_DB_USER=$WP_DB_USER
ARG WP_DB_PASSWORD=$WP_DB_PASSWORD
ARG WP_DB_HOST=$WP_DB_HOST

## Install MariaDB dependencies
# RUN ls -l /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-server
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-client
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-common
RUN apt-get install -y -o Debug::pkgProblemResolver=yes tzdata
RUN apt-get install -y -o Debug::pkgProblemResolver=yes systemd
RUN rm -rf /var/lib/apt/lists/*

## Prepare files & change Permissions
# COPY my.cnf /etc/mysql/
RUN mkdir -p /var/lib/mysql
RUN chown -hR mysql:mysql /var/lib/mysql
RUN chmod 755 -R /var/lib/mysql/
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld
RUN chmod 755 /run/mysqld

COPY entrypoint.sh /entrypoint.sh
RUN sed -i "s/MYSQL_ADMIN_PASSWORD/$MY_SQL_ADMIN_PASSWORD/g" /entrypoint.sh
RUN sed -i "s/WP_DB_NAME/$WP_DB_NAME/g" /entrypoint.sh
RUN sed -i "s/WP_DB_USER/$WP_DB_USER/g" /entrypoint.sh
RUN sed -i "s/WP_DB_PASSWORD/$WP_DB_PASSWORD/g" /entrypoint.sh
RUN sed -i "s/WP_DB_HOST/$WP_DB_HOST/g" /entrypoint.sh
RUN chmod +x /entrypoint.sh
# CMD ["/entrypoint.sh"]
# RUN service mariadb start
# RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql
# RUN mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY $WP_ADMIN_PASSWORD;"
# RUN mysql -u root -e "SET PASSWORD = $WP_ADMIN_PASSWORD;"
# RUN mysql -u root -e "CREATE DATABASE $WP_DB_NAME;"
# RUN mysql -u root -e "CREATE USER '$WP_DB_USER'@'$DB_HOST' IDENTIFIED BY '$WP_DB_PASSWORD';"
# RUN mysql -u root -e "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'$WP_DB_HOST';"

## Open network ports
EXPOSE 3306
## Start MariaDB service
# ENTRYPOINT ["mysqld_safe", "--user=mysql"]


## Debugging
# ENTRYPOINT ["which", "cat"]
# ENTRYPOINT ["which", "ls"]
# ENTRYPOINT ["cat", "/etc/os-release"]
# ENTRYPOINT ["ls", "-al", "/var/lib/mysql/"]
# ENTRYPOINT ["fgrep", "mysql", "/etc/passwd"]
# ENTRYPOINT ["fgrep", "999", "/etc/passwd"]
# ENTRYPOINT ["ls", "-l", "/var/log/*log"]
# ENTRYPOINT ["ls", "-l", "/var/log/faillog", "/var/log/lastlog"]
# ENTRYPOINT ["tail", "-f", "/var/log/syslog"]
# ENTRYPOINT ["tail", "/var/log/nginx/error.log"]
# ENTRYPOINT ["cat", "/var/log/faillog"]
# ENTRYPOINT ["cat", "/var/log/lastlog"]
