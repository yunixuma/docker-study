FROM debian:bullseye-slim

# Install WordPress dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-fpm
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-phar
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-intl
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-dom
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-mysqli
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-json
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-xml
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-xmlreader
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-ctype
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-curl
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-zlib
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-openssl
RUN apt-get install -y -o Debug::pkgProblemResolver=yes wordpress
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-client
RUN rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
# COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
# COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Enable OpenSSL extension
# RUN echo "extension=openssl" >> /etc/php/7.4/fpm/conf.d/20-openssl.ini

# Start PHP-FPM
CMD ["php-fpm7.4", "-F"]

# Copy WordPress files
COPY . /var/www/html

# Start the WordPress application
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
