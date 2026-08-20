# Render: repo has ZIP + this Dockerfile. Unzips and runs Laravel on Postgres/MySQL.
FROM php:8.3-cli-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    git unzip libzip-dev libpng-dev libonig-dev libxml2-dev libpq-dev \
    && docker-php-ext-install pdo_mysql pdo_pgsql mbstring zip bcmath gd pcntl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY lounge-system-v1.zip /tmp/lounge-system-v1.zip

RUN unzip -q /tmp/lounge-system-v1.zip -d /tmp \
    && cp -a /tmp/lounge-app/. /var/www/html/ \
    && rm -rf /tmp/lounge-app /tmp/lounge-system-v1.zip

RUN composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader --no-scripts \
    && mkdir -p \
        storage/framework/cache \
        storage/framework/sessions \
        storage/framework/views \
        storage/logs \
        storage/app/public \
        bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && php artisan package:discover --ansi || true

RUN chmod +x /var/www/html/docker/start.sh

EXPOSE 10000
CMD ["/var/www/html/docker/start.sh"]
