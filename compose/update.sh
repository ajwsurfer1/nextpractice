#!/bin/bash

CDIR=$(pwd)
echo " * stopping docker practicenext docker container ..."
cd /srv/docker/practicenext/compose
docker-compose stop
cd $CDIR
echo " * done."

echo " * copying ./html/* files to /srv/docker/practicenext/html/ ..."
rm -Rf dist
rm -Rf /srv/docker/practicenext/html/*
tar xvzf dist.tar.gz
cp -Rf dist/* /srv/docker/practicenext/html/
rm -Rf dist
echo " * done."

echo " * starting ar_vuejs docker container ..."
cd /srv/docker/practicenext/compose
docker-compose up -d
cd $CDIR
echo " * done."
