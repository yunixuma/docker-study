FROM debian:bullseye-slim

# Install WordPress dependencies
# RUN ls -l /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y -o Debug::pkgProblemResolver=yes nginx
RUN apt-get install -y -o Debug::pkgProblemResolver=yes openssl
RUN apt-get install -y -o Debug::pkgProblemResolver=yes ca-certificates
RUN apt-get install -y -o Debug::pkgProblemResolver=yes curl
RUN rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
# COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
# COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Enable OpenSSL extension
# RUN echo "extension=openssl" >> /etc/php/7.4/fpm/conf.d/20-openssl.ini

# # Start PHP-FPM
# ENTRYPOINT ["php-fpm7.4", "-F"]

# Copy WordPress files
# COPY . /var/www/html

COPY ./nginx.conf /etc/nginx/
RUN chmod -R 755 /var/www/html

EXPOSE 80 443
ENTRYPOINT ["nginx", "-g", "daemon off;"]

ENTRYPOINT ["which", "cat"]
ENTRYPOINT ["which", "ls"]
ENTRYPOINT ["cat", "/etc/os-release"]
# ENTRYPOINT ["ls", "-l", "/var/log/"]
# ENTRYPOINT ["ls", "-l", "/var/log/faillog", "/var/log/lastlog"]
# ENTRYPOINT ["ls", "-l", "/var/log/faillog", "/var/log/lastlog"]
# ENTRYPOINT ["tail", "-f", "/var/log/syslog"]
# ENTRYPOINT ["cat", "/var/log/mysql/error.log"]
# ENTRYPOINT ["cat", "/var/log/faillog"]
# ENTRYPOINT ["cat", "/var/log/lastlog"]
