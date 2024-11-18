#!/usr/bin/env bash

echo "* Stopping Fooocus Web Service ..."
CDIR=$(pwd)
cd /srv/docker/fooocus/compose
docker-compose stop
cd $CDIR
echo " * done"

echo "* Updating software ..."
# add update commands here, add libraries modeles, etc...
echo "* done"


echo "* Starting Fooocus Web Service ..."
CDIR=$(pwd)
cd /srv/docker/fooocus/compose
docker-compose up -d
cd $CDIR
echo "* done."
