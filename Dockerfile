FROM ubuntu:16.04

ENV LANG C.UTF-8

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  git ca-certificates

WORKDIR /home
RUN git clone https://github.com/rouault/gdal2
RUN git clone https://github.com/qgis/QGIS.git

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  build-essential cmake flex bison pyqt5-dev qttools5-dev \
  qtpositioning5-dev libqt5svg5-dev libqt5webkit5-dev  libqt5gui5 \
  libqt5scripttools5 qtscript5-dev libqca-qt5-2-dev \
  libgeos-dev libqt5xmlpatterns5-dev libqt5scintilla2-dev \
  pyqt5.qsci-dev python3-pyqt5.qsci libgsl-dev txt2tags libproj-dev \
  libqwt-qt5-dev libspatialindex-dev pyqt5-dev-tools qttools5-dev-tools \
  qt5-default python3-future python3-pyqt5.qtsql python3-psycopg2 \
  libqjson-dev swig libspatialite-dev libpq-dev \
  x11-apps
  #libgdal-dev grass-dev

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  libxerces-c-dev libcurl4-gnutls-dev

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  libqt5sql5-sqlite python3-yaml python3-numpy python3-pyproj python3-pip libsqlite3-mod-spatialite

COPY ./scripts/ /home/scripts/
RUN /home/scripts/build_gdal.sh

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  libqca-qt5-2-dev libqca-qt5-2-plugins
  # libqca2-plugin-ossl

RUN /home/scripts/build_qgis.sh

# some development tools
RUN pip3 install pydevd
RUN apt-get install --no-install-recommends -y \
    apt-file
RUN apt-file update

RUN apt-get install --no-install-recommends -y \
    sudo postgresql-client

# A few tunable variables for QGIS
#ENV QGIS_DEBUG 5
#ENV QGIS_LOG_FILE /proc/self/fd/1
#ENV PGSERVICEFILE /project/pg_service.conf
#ENV QGIS_PROJECT_FILE /project/project.qgs

#CMD ["/start.sh"]

COPY widget-plugins/qgis_customwidgets.py /usr/lib/python3/dist-packages/PyQt5/uic/widget-plugins/qgis_customwidgets.py

RUN useradd qgis
USER qgis

RUN mkdir -p /home/qgis/qgisgmlas/data
COPY qgisgmlas-datasets.tar.gz /home/qgis/qgisgmlas/data/

WORKDIR /home/qgis/qgisgmlas/data
RUN tar -zxvf qgisgmlas-datasets.tar.gz

WORKDIR /home/qgis

CMD /usr/bin/qgis
