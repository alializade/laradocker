#!/bin/bash

# Ensure that Docker is running...
if docker info >/dev/null 2>&1 -ne 0; then
  echo "Docker is not running."

  exit 1
fi

echo "Enter your project name:"
read -r NAME
mkdir NAME && cs NAME

docker run -it --rm -v ${pwd}:/www/html/${NAME}.com/ alpine/git clone git@github.com:alializade/laradocker.git

#docker run --rm \
#    -v "$(pwd)":/opt \
#    -w /opt \
#    laravelsail/php81-composer:latest \
#    bash -c "laravel new exam && cd exam && php ./artisan sail:install --with=mysql,redis,meilisearch,mailhog,selenium "

# sed for composer
# sed for .env file

cd "$NAME" || exit

echo ""

#CYAN='\033[0;36m'
#LIGHT_CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'


if sudo -n true 2>/dev/null eq 0; then
  sudo chown -R "$USER": .
else
  echo -e "${WHITE}Please provide your password so we can make some final adjustments to your application's permissions.${NC}"
  echo ""
  sudo chown -R "$USER": .
  echo ""
  echo -e "${WHITE}Thank you! We hope you build something incredible. Dive in with:${NC} cd exam && ./vendor/bin/sail up"
fi
