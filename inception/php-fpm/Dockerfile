FROM debian:bullseye-slim

# Install WordPress dependencies
RUN apk --no-cache add wordpress php7-mysqli php7-json php7-openssl php7-curl php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype

# Copy WordPress files
COPY . /var/www/html

# Start the WordPress application
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
