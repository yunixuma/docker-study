## Pull the base image
FROM debian:bullseye-slim
# FROM debian:bullseye

## Install MariaDB dependencies
# RUN ls -l /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-server
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-client
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-common
RUN apt-get install -y -o Debug::pkgProblemResolver=yes tzdata
RUN rm -rf /var/lib/apt/lists/*

## Prepare files & change Permissions
# COPY my.cnf /etc/mysql/
RUN mkdir -p /var/lib/mysql
RUN chown -hR mysql:mysql /var/lib/mysql
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld
# RUN chmod 755 -R /var/lib/mysql/

## Open network ports
EXPOSE 3306
## Start MariaDB service
ENTRYPOINT ["mysqld", "--user=mysql"]


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
