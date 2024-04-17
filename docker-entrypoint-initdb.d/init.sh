#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER dbuser WITH ENCRYPTED PASSWORD 'MsdIUV5W8OaMOfipZLe91Dk';
  CREATE DATABASE dbuser OWNER dbuser;

  CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
EOSQL
