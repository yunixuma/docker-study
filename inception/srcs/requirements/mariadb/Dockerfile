# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ykosaka <ykosaka@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/14 01:04:04 by ykosaka           #+#    #+#              #
#    Updated: 2024/10/12 09:02:22 by ykosaka          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

## Pull the base image
FROM debian:bullseye-slim
# FROM debian:bullseye

## Args for building the image
ARG PATH_CONF=/etc/mysql/mariadb.conf.d/50-server.cnf
ARG DIR_WORK=/root
ARG FILE_CMD=docker-entrypoint.sh
ARG FILE_QUERY=setup.sql
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
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes systemd

# RUN apt-get install -y -o Debug::pkgProblemResolver=yes sudo
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes vim
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes net-tools
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes iputils-ping
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
COPY ./$FILE_QUERY $DIR_WORK/
RUN sed -i "s/\$MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/g" $DIR_WORK/$FILE_QUERY
RUN sed -i "s/\$WP_DB_HOST/$WP_DB_HOST/g" $DIR_WORK/$FILE_QUERY
RUN sed -i "s/\$WP_DB_NAME/$WP_DB_NAME/g" $DIR_WORK/$FILE_QUERY
RUN sed -i "s/\$WP_DB_USER/$WP_DB_USER/g" $DIR_WORK/$FILE_QUERY
RUN sed -i "s/\$WP_DB_PASSWORD/$WP_DB_PASSWORD/g" $DIR_WORK/$FILE_QUERY

## Configure MariaDB
RUN grep "bind-address[ \t]*=[ \t]*$WP_DB_HOST" $PATH_CONF || sed -i "/\(bind-address.*$\)/a bind-address            = $WP_DB_HOST" $PATH_CONF
# sed -i "/\(bind-address.*$\)/a bind-address            = $IP_DB" $PATH_CONF 

## Open network ports
EXPOSE 3306

## Execute docker-entrypoint.sh script
COPY ./$FILE_CMD $DIR_WORK/
RUN chmod +x $DIR_WORK/$FILE_CMD
## Setup & start MariaDB service
# CMD ["mysqld_safe", "--user=$WP_DB_USER"]
ENTRYPOINT [ "sh", "-c", "/root/docker-entrypoint.sh" ] 
# ENTRYPOINT [ "bash" ]

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
