#!/bin/bash

docker info >/dev/null 2>&1

# Ensure that Docker is running...
if [ $? -ne 0 ]; then
  echo "Docker is not running."

  exit 1
fi

echo "Enter your project name:"
reas NAME

#docker run --rm \
#    -v "$(pwd)":/opt \
#    -w /opt \
#    laravelsail/php81-composer:latest \
#    bash -c "laravel new exam && cd exam && php ./artisan sail:install --with=mysql,redis,meilisearch,mailhog,selenium "

cd "$NAME" || exit

echo ""

CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

sudo -n true 2>/dev/null
if $? eq 0; then
  sudo chown -R "$USER": .
else
  echo -e "${WHITE}Please provide your password so we can make some final adjustments to your application's permissions.${NC}"
  echo ""
  sudo chown -R "$USER": .
  echo ""
  echo -e "${WHITE}Thank you! We hope you build something incredible. Dive in with:${NC} cd exam && ./vendor/bin/sail up"
fi
