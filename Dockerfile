
# JavaScript build stage
FROM node:21-alpine AS js
WORKDIR /var/www/html
COPY package.json yarn.lock ./
COPY . . 
RUN yarn install
RUN yarn build 

# Composer build stage
FROM composer:2.2 AS composer

# PHP build stage
FROM php:8.0-fpm as php
ENV PHP_INI_MEMORY_LIMIT 128M
RUN apt update && apt install -y git 
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions zip xmlrpc exif bz2 gd imap intl pdo_mysql opcache tidy xsl
COPY --from=composer /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/html
COPY . .
RUN composer install --no-dev --optimize-autoloader
COPY --from=js /var/www/html/node_modules ./node_modules
COPY --from=js /var/www/html/public/build ./public/build
COPY ./config/php.ini /usr/local/etc/php/php.ini
RUN chown -R www-data:www-data ./var
CMD [ "sh","-c","make && php-fpm"]





