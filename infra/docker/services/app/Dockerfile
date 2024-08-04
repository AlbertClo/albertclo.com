FROM php:8.3-fpm

ARG user
ARG uid

RUN apt-get update  \
    && apt-get install -y \
        build-essential \
        curl \
        git \
        jpegoptim optipng pngquant gifsicle \
        locales \
        zip \
        unzip \
        vim \
        nano \
        libonig-dev  \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install exif \
    && docker-php-ext-install pdo_mysql \
    && useradd -G www-data,root -u $uid -d /home/$user $user \
    && mkdir -p /home/$user/.composer \
    && chown -R $user:$user /home/$user \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && echo "* * * * * root php /var/www/artisan schedule:run >> /var/log/cron.log 2>&1" >> /etc/crontab \
    && touch /var/log/cron.log

WORKDIR /var/www

USER $user
