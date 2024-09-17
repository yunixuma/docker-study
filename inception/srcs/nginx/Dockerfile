## Pull the base image
FROM debian:bullseye-slim
# FROM debian:bullseye

## Install nginx dependencies
# RUN ls -l /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y -o Debug::pkgProblemResolver=yes nginx
RUN apt-get install -y -o Debug::pkgProblemResolver=yes openssl
RUN apt-get install -y -o Debug::pkgProblemResolver=yes ca-certificates
RUN apt-get install -y -o Debug::pkgProblemResolver=yes curl
RUN rm -rf /var/lib/apt/lists/*

# Enable OpenSSL extension
# RUN echo "extension=openssl" >> /etc/php/7.4/fpm/conf.d/20-openssl.ini

## Prepare files & change Permissions
COPY ./nginx.conf /etc/nginx/
RUN chmod -R 755 /var/www/html

## Open network ports
EXPOSE 80 443
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
