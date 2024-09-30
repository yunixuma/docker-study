## Pull the base image
FROM debian:bullseye-slim
# FROM debian:bullseye

## Args for building the image
ARG MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
ARG WP_DB_HOST=$WP_DB_HOST
ARG WP_DB_NAME=$WP_DB_NAME
ARG WP_DB_USER=$WP_DB_USER
ARG WP_DB_PASSWORD=$WP_DB_PASSWORD

## Install MariaDB dependencies
# RUN ls -l /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-server
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-client
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-common
RUN apt-get install -y -o Debug::pkgProblemResolver=yes tzdata
RUN apt-get install -y -o Debug::pkgProblemResolver=yes systemd

RUN apt-get install -y -o Debug::pkgProblemResolver=yes sudo
RUN apt-get install -y -o Debug::pkgProblemResolver=yes vim
RUN apt-get install -y -o Debug::pkgProblemResolver=yes net-tools
RUN apt-get install -y -o Debug::pkgProblemResolver=yes iputils-ping
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
COPY entrypoint.sql /entrypoint.sql
RUN sed -i "s/\$MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g" /entrypoint.sql
RUN sed -i "s/\$WP_DB_HOST/$WP_DB_HOST/g" /entrypoint.sql
RUN sed -i "s/\$WP_DB_NAME/$WP_DB_NAME/g" /entrypoint.sql
RUN sed -i "s/\$WP_DB_USER/$WP_DB_USER/g" /entrypoint.sql
RUN sed -i "s/\$WP_DB_PASSWORD/$WP_DB_PASSWORD/g" /entrypoint.sql
RUN chmod +x /entrypoint.sh
RUN sh /entrypoint.sh; exit 0 
# COPY entrypoint.sql /entrypoint.sql

# RUN service mariadb start
# RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql
# RUN mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY $MYSQL_ROOT_PASSWORD;"
# RUN mysql -u root -e "SET PASSWORD = $MYSQL_ROOT_PASSWORD;"
# RUN mysql -u root -e "CREATE DATABASE $WP_DB_NAME;"
# RUN mysql -u root -e "CREATE USER '$WP_DB_USER'@'$WP_DB_HOST' IDENTIFIED BY '$WP_DB_PASSWORD';"
# RUN mysql -u root -e "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'$WP_DB_HOST';"

## Open network ports
EXPOSE 3306
## Start MariaDB service
# ENTRYPOINT ["mysqld_safe", "--user=$WP_DB_USER"]


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
