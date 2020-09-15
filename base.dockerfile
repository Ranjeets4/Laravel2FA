FROM php:7.1.11-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev \
    curl git zlib1g-dev mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install zip mcrypt pdo_mysql

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html

WORKDIR /var/www/html

RUN composer install && ./vendor/bin/phpunit
