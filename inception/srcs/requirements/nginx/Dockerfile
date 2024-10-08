## Pull the base image
FROM debian:bullseye-slim
# FROM debian:bullseye

## Install nginx dependencies
# RUN ls -l /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y -o Debug::pkgProblemResolver=yes nginx
RUN apt-get install -y -o Debug::pkgProblemResolver=yes openssl
RUN apt-get install -y -o Debug::pkgProblemResolver=yes ca-certificates
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes curl

# RUN apt-get install -y -o Debug::pkgProblemResolver=yes sudo
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes vim
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes net-tools
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes lsof
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes iputils-ping
RUN rm -rf /var/lib/apt/lists/*

# Enable OpenSSL extension
# RUN echo "extension=openssl" >> /etc/php/7.4/fpm/conf.d/20-openssl.ini

## Prepare files & change Permissions
COPY ./default.conf /etc/nginx/conf.d/
COPY ./ssl/server.crt /etc/ssl/certs/nginx.crt
COPY ./ssl/server.key /etc/ssl/private/nginx.key
# RUN chmod -R 755 /var/www/html

# COPY setup.sh /root/setup.sh
# RUN chmod +x /root/setup.sh
# RUN sh /root/setup.sh; exit 0

## Open network ports
EXPOSE 443
## Start nginx service
ENTRYPOINT ["nginx", "-g", "daemon off;"]


## Debugging
# ENTRYPOINT ["which", "cat"]
# ENTRYPOINT ["which", "ls"]
# ENTRYPOINT ["cat", "/etc/os-release"]
# ENTRYPOINT ["ls", "-l", "/var/log/"]
# ENTRYPOINT ["ls", "-l", "/var/log/faillog", "/var/log/lastlog"]
# ENTRYPOINT ["tail", "-f", "/var/log/syslog"]
# ENTRYPOINT ["cat", "/var/log/mysql/error.log"]
# ENTRYPOINT ["cat", "/var/log/faillog"]
# ENTRYPOINT ["cat", "/var/log/lastlog"]
