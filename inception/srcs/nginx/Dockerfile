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
# CMD ["php-fpm7.4", "-F"]

# Copy WordPress files
# COPY . /var/www/html

CMD ["which", "cat"]
CMD ["which", "ls"]
CMD ["cat", "/etc/os-release"]
# CMD ["ls", "-l", "/var/log/"]
CMD ["ls", "-l", "/var/log/faillog", "/var/log/lastlog"]
CMD ["ls", "-l", "/var/log/faillog", "/var/log/lastlog"]
# CMD ["tail", "-f", "/var/log/syslog"]
# CMD ["cat", "/var/log/mysql/error.log"]
# CMD ["cat", "/var/log/faillog"]
# CMD ["cat", "/var/log/lastlog"]

COPY ./nginx.conf /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]
