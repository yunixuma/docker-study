## Pull the base image
FROM debian:bullseye-slim
# FROM debian:bullseye

## Args for building the image
ARG WP_DB_NAME=$WP_DB_NAME
ARG WP_DB_USER=$WP_DB_USER
ARG WP_DB_PASSWORD=$WP_DB_PASSWORD
ARG WP_DB_HOST=$WP_DB_HOST
ARG WP_HOME=$WP_HOME
ARG WP_TITLE=$WP_TITLE
ARG WP_ADMIN_USER=$WP_ADMIN_USER
ARG WP_ADMIN_PASSWORD=$WP_ADMIN_PASSWORD
ARG WP_ADMIN_EMAIL=$WP_ADMIN_EMAIL
ARG WP_SUB_USER=$WP_SUB_USER
ARG WP_SUB_EMAIL=$WP_SUB_EMAIL
ARG WP_SUB_PASSWORD=$WP_SUB_PASSWORD

## Install WordPress dependencies
# RUN ls -l /etc/apt/sources.list
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
RUN apt-get install -y -o Debug::pkgProblemResolver=yes curl
RUN apt-get install -y -o Debug::pkgProblemResolver=yes wordpress
RUN apt-get install -y -o Debug::pkgProblemResolver=yes mariadb-client
RUN rm -rf /var/lib/apt/lists/*

## Prepare files & change Permissions
RUN chmod -R 755 /var/www/html

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
# Setup WordPress
COPY entrypoint.sh /entrypoint.sh
RUN sed -i "s/\$WP_DB_HOST/$WP_DB_HOST/g" /entrypoint.sh
RUN sed -i "s/\$WP_DB_NAME/$WP_DB_NAME/g" /entrypoint.sh
RUN sed -i "s/\$WP_DB_USER/$WP_DB_USER/g" /entrypoint.sh
RUN sed -i "s/\$WP_DB_PASSWORD/$WP_DB_PASSWORD/g" /entrypoint.sh
RUN sed -i "s/\$WP_HOME/$WP_HOME/g" /entrypoint.sh
RUN sed -i "s/\$WP_TITLE/$WP_TITLE/g" /entrypoint.sh
RUN sed -i "s/\$WP_ADMIN_USER/$WP_ADMIN_USER/g" /entrypoint.sh
RUN sed -i "s/\$WP_ADMIN_PASSWORD/$WP_ADMIN_PASSWORD/g" /entrypoint.sh
RUN sed -i "s/\$WP_ADMIN_EMAIL/$WP_ADMIN_EMAIL/g" /entrypoint.sh
RUN sed -i "s/\$WP_SUB_USER/$WP_SUB_USER/g" /entrypoint.sh
RUN sed -i "s/\$WP_SUB_EMAIL/$WP_SUB_EMAIL/g" /entrypoint.sh
RUN sed -i "s/\$WP_SUB_PASSWORD/$WP_SUB_PASSWORD/g" /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN sh /entrypoint.sh
# COPY entrypoint.sh /entrypoint.sh

# Configure PHP-FPM
# COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
# COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Enable OpenSSL extension
# RUN echo "extension=openssl" >> /etc/php/7.4/fpm/conf.d/20-openssl.ini

# Start PHP-FPM
ENTRYPOINT ["php-fpm7.4", "-F"]
# Start the WordPress application
ENTRYPOINT ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
