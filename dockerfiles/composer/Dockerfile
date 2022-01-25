FROM composer:2

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat

RUN addgroup -g 1000 --system composer
RUN adduser -G composer --system -D -s /bin/sh -u 1000 composer

WORKDIR /home/api/public_html
