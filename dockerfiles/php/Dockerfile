FROM php:8-fpm-alpine

# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat \
 && addgroup -g 1000 --system api \
 && adduser -G api --system -D -s /bin/sh -u 1000 api \
 && apk add --no-cache libc6-compat git bash zip zlib \
 && mkdir -p /home/api/public_html \
 && chown -R api:api /home/api \
 && sed -i "s/user = www-data/user = api/g; s/group = www-data/group = api/g" /usr/local/etc/php-fpm.d/www.conf \
 && echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf \
 && mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/5.3.4.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install pdo_mysql exif pcntl bcmath redis

WORKDIR /home/api/public_html
USER api

#RUN docker-php-ext-install zlib gd

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
