sudo -u postgres psql

ALTER USER postgres WITH PASSWORD 'postgres';

CREATE ROLE qgis LOGIN
  PASSWORD 'qgis'
  SUPERUSER INHERIT CREATEDB CREATEROLE NOREPLICATION;

CREATE DATABASE inspire
  WITH OWNER = qgis
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;

CREATE EXTENSION postgis;
\q

exit
