## Pull the base image
FROM debian:bullseye-slim
# FROM debian:bullseye

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

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
# Setup WordPress
RUN cd /var/www/html
RUN wp core download --path="/var/www/html" --allow-root
# RUN wp core config --dbname="$WP_DB_NAME" --dbuser="$WP_DB_USER" --dbpass="$WP_DB_PASSWORD" --dbhost="$WP_DB_HOST" --path="/var/www/html" --allow-root
# RUN wp core install --url="$WP_HOME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="/var/www/html" --allow-root
# RUN wp user create "$WP_SUB_USER" "$WP_SUB_EMAIL" --role=subscriber --user_pass="$WP_SUB_PASSWORD" --allow-root
# RUN wp plugin install --activate --allow-root

# Configure PHP-FPM
# COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
# COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Enable OpenSSL extension
# RUN echo "extension=openssl" >> /etc/php/7.4/fpm/conf.d/20-openssl.ini

## Prepare files & change Permissions
RUN chmod -R 755 /var/www/html
COPY . /var/www/html

# Start PHP-FPM
ENTRYPOINT ["php-fpm7.4", "-F"]
# Start the WordPress application
ENTRYPOINT ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
