#!/bin/bash

CDIR=$(pwd)
echo " * Stopping Fooocus Web Service ..."

cd /srv/docker/fooocus/compose
docker-compose stop
docker-compose rm
cd $CDIR

echo " * Removing all files and directory from /srv/docker/fooocus ..."
rm -Rf /srv/docker/fooocus
echo " * done"
