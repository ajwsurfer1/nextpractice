#!/usr/bin/env bash

echo "* Building directory structure ..."

mkdir -p /srv/docker/fooocus/bin
mkdir -p /srv/docker/fooocus/python
mkdir -p /srv/docker/fooocus/compose


echo "* Starting Fooocus Web Service ..."
CDIR=$(pwd)
cp docker-compose.yml /srv/docker/fooocus/compose
cd /srv/docker/fooocus/compose
docker-compose up -d
cd $CDIR
echo " * done"
