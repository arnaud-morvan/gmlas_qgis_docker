#!/bin/bash

#git clone https://github.com/rouault/gdal2
cd /home/gdal2
git checkout gmlas
git fetch origin
git reset --hard origin/gmlas
cd gdal
./configure --prefix=/usr --without-libtool --with-xerces --with-curl --with-python=/usr/bin/python3 --with-spatialite
make clean
make -j8 -s
make install

cd /home/gdal2/gdal/swig
make -f GNUmakefile
make install
