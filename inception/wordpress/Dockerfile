FROM debian:bullseye-slim

# Install WordPress dependencies
# RUN apk --no-cache add php7-mysqli php7-json php7-openssl php7-curl php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype
# RUN apk --no-cache add wordpress
RUN apt-get update
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-xml
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-phar
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-intl
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-dom
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-mysqli
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-json
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-xmlreader
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-ctype
RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-curl
RUN apt-get install -y -o Debug::pkgProblemResolver=yes wordpress
# RUN apt-get install -y php7.4-openssl
# RUN apt-get install -y -o Debug::pkgProblemResolver=yes php7.4-zlib
RUN rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
# COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
# COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Enable OpenSSL extension
# RUN echo "extension=openssl" >> /etc/php/7.4/fpm/conf.d/20-openssl.ini

# Start PHP-FPM
# CMD ["php-fpm7.4", "-F"]

# Copy WordPress files
COPY . /var/www/html

# Start the WordPress application
# CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
