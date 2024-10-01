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

## Debugging
# RUN ls -al /var/lib/mysql >> ~/install.log 2>&1
# RUN whoami >> ~/install.log 2>&1
# RUN cat /etc/passwd >> ~/install.log 2>&1

## Prepare files & change Permissions
# COPY my.cnf /etc/mysql/
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld
RUN chmod 755 /run/mysqld
COPY ./setup.sql /root/setup.sql
RUN sed -i "s/\$MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g" /root/setup.sql
RUN sed -i "s/\$WP_DB_HOST/$WP_DB_HOST/g" /root/setup.sql
RUN sed -i "s/\$WP_DB_NAME/$WP_DB_NAME/g" /root/setup.sql
RUN sed -i "s/\$WP_DB_USER/$WP_DB_USER/g" /root/setup.sql
RUN sed -i "s/\$WP_DB_PASSWORD/$WP_DB_PASSWORD/g" /root/setup.sql

## Configure MariaDB
ARG PATH_CONF=/etc/mysql/mariadb.conf.d/50-server.cnf
RUN grep "bind-address[ \t]*=[ \t]*$WP_DB_HOST" $PATH_CONF || sed -i "/\(bind-address.*$\)/a bind-address            = $WP_DB_HOST" $PATH_CONF
# sed -i "/\(bind-address.*$\)/a bind-address            = $IP_DB" $PATH_CONF 

## Open network ports
EXPOSE 3306

## Execute entrypoint.sh script
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
## Setup & start MariaDB service
ENTRYPOINT [ "sh", "-c", "/root/entrypoint.sh"] 
# CMD ["mysqld_safe", "--user=$WP_DB_USER"]


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
