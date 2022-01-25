FROM node:17-alpine

ENV PORT 3000

# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
WORKDIR /home/node/public_html

COPY package*.json yarn*.lock ./

RUN apk add --no-cache libc6-compat \
    && mkdir -p /home/node/public_html \
    && yarn install \
    && chown -R node:node /home/node/public_html

USER node

EXPOSE 3000

ENV NEXT_TELEMETRY_DISABLED 1

CMD ["yarn", "dev"]