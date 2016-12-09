#!/bin/bash

#git clone https://github.com/rouault/gdal2
cd /home/gdal2
#git remote remove origin
#git remote add origin https://github.com/OSGeo/gdal.git
git fetch origin
git checkout gmlas
git reset --hard origin/gmlas
#git reset --hard origin/trunk

# Python bindings: gdal.VectorTranslate(): add spatSRS option
# https://github.com/rouault/gdal2/commit/02d58a66fd3f287afb8dd5878aa1026c1e12e5c0
git checkout 02d58a66fd3f287afb8dd5878aa1026c1e12e5c0

cd gdal
./configure --prefix=/usr --without-libtool --with-xerces --with-curl --with-python=/usr/bin/python3 --with-spatialite
make clean
make -j8 -s
make install

cd /home/gdal2/gdal/swig
make -f GNUmakefile
make install
