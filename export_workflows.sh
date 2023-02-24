#!/usr/bin/env bash

: ${EXPORT_DIR:="n8n-$(date +%Y%m%d)"}

: ${DATA_FOLDER:="/data/db"}/n8n:/home/node/.n8n

set -euo

docker run \
    -p 5678:5678 \
    -v /.env \
    -e N8N_ENCRYPTION_KEY \
    -e GENERIC_TIMEZONE \
    -e TZ \
    -e DB_TYPE \
    -e DB_POSTGRESDB_DATABASE \
    -e DB_POSTGRESDB_HOST \
    -e DB_POSTGRESDB_PORT \
    -e DB_POSTGRESDB_USER \
    -e DB_POSTGRESDB_SCHEMA \
    -e DB_POSTGRESDB_PASSWORD \
    -v $EXPORT_ROOT:/backup \
    -u node \
    n8nio/n8n \
    n8n export:workflow --backup --output=/backup/$EXPORT_DIR/ \
    --data=/data/db
