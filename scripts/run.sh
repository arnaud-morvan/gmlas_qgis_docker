#!/bin/bash

export XSOCK=/tmp/.X11-unix
export XAUTH=~/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
sudo chmod o+r 999 $XAUTH
sudo chmod o+r $XSOCK

#docker-compose up --force-recreate qgis
docker-compose up qgis
