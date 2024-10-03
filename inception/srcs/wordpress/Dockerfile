## Pull the base image
FROM debian:bullseye-slim
# FROM debian:bullseye

## Args for building the image
ARG WP_DB_NAME=$WP_DB_NAME
ARG WP_DB_USER=$WP_DB_USER
ARG WP_DB_PASSWORD=$WP_DB_PASSWORD
ARG WP_DB_HOST=$WP_DB_HOST
ARG WP_HOME=$WP_HOME
ENV WP_DB_HOST=$WP_DB_HOST
ENV WP_HOME=$WP_HOME
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

RUN apt-get install -y -o Debug::pkgProblemResolver=yes sudo
RUN apt-get install -y -o Debug::pkgProblemResolver=yes systemd
RUN apt-get install -y -o Debug::pkgProblemResolver=yes vim
RUN apt-get install -y -o Debug::pkgProblemResolver=yes net-tools
RUN apt-get install -y -o Debug::pkgProblemResolver=yes iputils-ping
RUN rm -rf /var/lib/apt/lists/*

## Prepare files & change Permissions
RUN mkdir -p /run/php/
RUN chmod 755 -R /run/php/
RUN chmod -R 755 /var/www/html

## Configure PHP-FPM
# COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
# COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf
ARG PATH_CONF='/etc/php/7.4/fpm/pool.d/www.conf'
RUN sed -i "s/\/run\/php\/php7.4-fpm.sock/9000/" $PATH_CONF

## Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# COPY setup.sh /setup.sh
# RUN sed -i "s/\$WP_DB_HOST/$WP_DB_HOST/g" /setup.sh
# RUN sed -i "s/\$WP_DB_NAME/$WP_DB_NAME/g" /setup.sh
# RUN sed -i "s/\$WP_DB_USER/$WP_DB_USER/g" /setup.sh
# RUN sed -i "s/\$WP_DB_PASSWORD/$WP_DB_PASSWORD/g" /setup.sh
# RUN sed -i "s/\$WP_HOME/$WP_HOME/g" /setup.sh
# RUN sed -i "s/\$WP_TITLE/$WP_TITLE/g" /setup.sh
# RUN sed -i "s/\$WP_ADMIN_USER/$WP_ADMIN_USER/g" /setup.sh
# RUN sed -i "s/\$WP_ADMIN_PASSWORD/$WP_ADMIN_PASSWORD/g" /setup.sh
# RUN sed -i "s/\$WP_ADMIN_EMAIL/$WP_ADMIN_EMAIL/g" /setup.sh
# RUN sed -i "s/\$WP_SUB_USER/$WP_SUB_USER/g" /setup.sh
# RUN sed -i "s/\$WP_SUB_EMAIL/$WP_SUB_EMAIL/g" /setup.sh
# RUN sed -i "s/\$WP_SUB_PASSWORD/$WP_SUB_PASSWORD/g" /setup.sh

## Enable OpenSSL extension
# RUN echo "extension=openssl" >> /etc/php/7.4/fpm/conf.d/20-openssl.ini

## Open network ports
# EXPOSE 3306
RUN echo "WP_DB_HOST=$WP_DB_HOST" >> /root/install.log
RUN echo "WP_HOME=$WP_HOME" >> /root/install.log
RUN echo "WP_TITLE=$WP_TITLE" >> /root/install.log
## Setup & start the WordPress application
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
ENTRYPOINT ["sh", "-c", "/root/entrypoint.sh"]
# CMD ["php", "-S", "0.0.0.0:443", "-t", "/var/www/html"]
# CMD ["php-fpm7.4", "-F"]
