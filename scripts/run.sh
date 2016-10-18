#!/bin/bash

export XSOCK=/tmp/.X11-unix
export XAUTH=~/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker-compose up --force-recreate qgis
