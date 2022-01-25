FROM php:8-fpm-alpine

RUN mkdir -p /home/api/public_html

WORKDIR /home/api/public_html

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat git bash zip zlib

RUN addgroup -g 1000 --system api
RUN adduser -G api --system -D -s /bin/sh -u 1000 api

RUN sed -i "s/user = www-data/user = api/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = api/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf
RUN chown -R api:api /home/api

RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/5.3.4.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install pdo_mysql exif pcntl bcmath redis

#RUN docker-php-ext-install zlib gd

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
