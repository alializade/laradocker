#!/bin/bash

set -e

CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Ensure that Docker is running...
if docker info -ne 0 >/dev/null 2>&1; then
  echo -e "${CYAN}Docker is not running."

  exit 1
fi

if [[ -d ./install_package ]]; then rm -rf ./install_package; echo -e "${LIGHT_CYAN}install_package directory wiped"; fi
docker run -it --rm -v "$HOME"/.ssh:/root/.ssh -v "$PWD":/git alpine/git clone git@github.com:alializade/laradocker.git ./install_package

if [[ -d ./web ]]; then rm -rf ./web; echo -e "${LIGHT_CYAN}web directory wiped"; fi
docker run -it --rm -v "$PWD":/app -w /app node:17-alpine yarn create next-app --typescript ./web

if [[ -d ./api ]]; then rm -rf ./api; echo -e "${CYAN}api directory wiped"; fi
docker run -it --rm -v "$PWD":/app -w /app composer:2 create-project --prefer-dist laravel/laravel ./api

chmod -R 777 ./api/bootstrap/cache ./api/storage

sed -i -e "s|APP_URL=http://localhost|APP_URL=http://localhost:8080|" ./api/.env;
sed -i -e "s/DB_HOST=127.0.0.1/DB_HOST=mysql/" ./api/.env;
sed -i -e "s/DB_PASSWORD=/DB_PASSWORD=secret/" ./api/.env;

echo ""

if sudo -n true eq 0 2>/dev/null; then
  sudo chown -R "$USER": .
else
  echo -e "${WHITE}Please provide your password so we can make some final adjustments to your application's permissions.${NC}"
  echo ""
  sudo chown -R "$USER": .
  echo ""
  echo -e "${WHITE}Thank you! We hope you build something incredible. Dive in with:${NC} docker-compose up --build -d nginx"
fi

sed -i.bak -e "s|BASE_NAME|${PWD##*/}|g" ./docker-compose.yml;

docker-compose up --build -d nginx

echo -e "=> ${CYAN}Hello World :)"

echo -e "=> ${WHITE}In order to create database tables:"

echo -e "=> ${LIGHT_CYAN}$ docker-compose run --rm artisan migrate"

echo -e "=> ${CYAN}By ${WHITE}Ali Alizade ${CYAN}[ali.alizade@outlook.com]"
