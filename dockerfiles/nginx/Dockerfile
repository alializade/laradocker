FROM nginx:stable-alpine

# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat \
 && sed -i "s/user  nginx/user nginx/g" /etc/nginx/nginx.conf \
 && mkdir -p /home/node/pubilc_html

ADD ./nginx/default.conf ./nginx/api.conf /etc/nginx/conf.d/