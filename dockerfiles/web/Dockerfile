# Install dependencies only when needed
FROM node:17-alpine

ENV PORT 3000

# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat

RUN mkdir -p /home/node/public_html
WORKDIR /home/node/public_html

COPY package*.json yarn*.lock ./
RUN yarn install

COPY ./ ./

RUN chown -R node:node /home/node/public_html
USER node

RUN yarn build
EXPOSE 3000

ENV NEXT_TELEMETRY_DISABLED 1

CMD ["yarn", "dev"]