FROM php:8.3-fpm

ARG user
ARG uid
ARG groupId

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libpq-dev

#RUN useradd -G www-data,root -u $uid -d /home/$user $user \
#    && mkdir -p /home/$user/.composer \
#    && chown -R $user:$user /home/$user \

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_pgsql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

RUN usermod -u ${uid} www-data && groupmod -g ${groupId} www-data

# Change current user to www-data
USER www-data
