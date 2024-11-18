#!/bin/bash

CDIR=$(pwd)
echo " * shutting down practicenext container ..."
cd /srv/docker/practicenext/compose
docker-compose stop
docker-compose rm
cd $CDIR
echo " * done."

echo " * removing /srv/docker/practicenext directory ..."
rm -Rf /srv/docker/practicenext
echo " * done."
