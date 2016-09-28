FROM ubuntu:16.04

ENV LANG C

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

COPY ./scripts/ /home/scripts/
RUN /home/scripts/build_gdal.sh
RUN /home/scripts/build_qgis.sh

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  libqt5sql5-sqlite python3-yaml python3-numpy python3-pyproj python3-pip

RUN pip3 install pydevd

# A few tunable variables for QGIS
#ENV QGIS_DEBUG 5
#ENV QGIS_LOG_FILE /proc/self/fd/1
#ENV PGSERVICEFILE /project/pg_service.conf
#ENV QGIS_PROJECT_FILE /project/project.qgs

#CMD ["/start.sh"]

CMD /usr/bin/qgis
