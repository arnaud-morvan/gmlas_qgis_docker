#!/bin/bash

#git clone https://github.com/rouault/gdal2
cd /home/gdal2
git checkout gmlas
git fetch origin
git merge origin/gmlas --ff-only
cd gdal
./configure --prefix=/usr --without-libtool --with-xerces --with-python=/usr/bin/python3 --with-spatialite
make -j8 -s
make install

cd /home/gdal2/gdal/swig
make -f GNUmakefile
make install
