#!/usr/bin/env bash

echo "* Building directory structure ..."

mkdir -p /srv/docker/practicenext/html
mkdir -p /srv/docker/practicenext/db
mkdir -p /srv/docker/practicenext/compose

CDIR=$(pwd) # Store curent directory path in $CDIR

echo "* Adding SPA content to /srv/docker/practicenext/html ..."
cp dist.tar.gz /srv/docker/practicenext/html
cd /srv/docker/practicenext/html
tar xvzf dist.tar.gz
mv dist/* /srv/docker/practicenext/html
rm dist.tar.gz
rm -Rf dist
cd $CDIR

echo "* Starting AJ Surfer Web Service ..."

cp docker-compose.yml /srv/docker/practicenext/compose
cp download_counter.json /srv/docker/practicenext/compose
cd /srv/docker/practicenext/compose
docker-compose up -d
cd $CDIR
echo " * done"