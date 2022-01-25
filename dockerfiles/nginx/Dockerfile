FROM nginx:stable-alpine
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

RUN addgroup -g 1000 --system nginx
RUN adduser -G nginx --system -D -s /bin/sh -u 1000 nginx
RUN sed -i "s/user  nginx/user nginx/g" /etc/nginx/nginx.conf

ADD ./nginx/default.conf /etc/nginx/conf.d/
ADD ./nginx/api.conf /etc/nginx/conf.d/

RUN mkdir -p /home/node/pubilc_html