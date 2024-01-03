#!/bin/bash

set -e

apk add postgresql-client
apk add zip

cd /tmp
unzip -o concept_recommended.csv.zip

PGPASSWORD=$(cat /run/secrets/PHOEBE_PG_PASSWORD) psql -v vocab_schema=$PHOEBE_PG_SCHEMA -h $PHOEBE_PG_HOST -U $PHOEBE_PG_USER -d $PHOEBE_PG_DATABASE -a -f concept_recommended.sql

echo 'Now loading: concept_recommended'
PGPASSWORD=$(cat /run/secrets/PHOEBE_PG_PASSWORD) psql -h $PHOEBE_PG_HOST -d $PHOEBE_PG_DATABASE -U $PHOEBE_PG_USER \
    -c "\COPY $PHOEBE_PG_SCHEMA.concept_recommended FROM concept_recommended.csv (DELIMITER E',', FORMAT CSV, NULL '""', QUOTE E'\b', HEADER, ENCODING 'UTF8')"
echo 'Finished loading: concept_recommended'

echo 'All done, shutting down. Feel free to remove container.'