#!/bin/bash

#git clone https://github.com/qgis/QGIS.git
cd /home/QGIS
git fetch origin
git merge origin/master --ff-only

mkdir -p /home/build
cd /home/build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
	-DWITH_INTERNAL_QWTPOLAR=TRUE \
	-DWITH_GRASS=FALSE \
	-DWITH_GRASS7=FALSE \
	../QGIS
make -j8
make install
