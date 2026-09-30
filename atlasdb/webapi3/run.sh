#!/bin/sh
# Seeds WebAPI 3.0's security tables (login users, admin role permissions,
# trexsql permissions). Waits for WebAPI to finish its Flyway migrations,
# since the permission tables only exist afterwards. Every script is
# idempotent, so this runs on each `docker compose up`.
set -e

# jdbc:postgresql://host:port/db?params -> host, port, db
url="${WEBAPI_DATASOURCE_URL#jdbc:postgresql://}"
hostport="${url%%/*}"
db="${url#*/}"; db="${db%%\?*}"
export PGHOST="${hostport%%:*}"
export PGPORT="5432"
[ "$hostport" != "$PGHOST" ] && export PGPORT="${hostport#*:}"
export PGDATABASE="$db"
export PGUSER="$WEBAPI_DATASOURCE_USERNAME"
export PGPASSWORD="$(cat /run/secrets/WEBAPI_DATASOURCE_PASSWORD)"

echo "Waiting for WebAPI to be up..."
until wget -q -O /dev/null http://ohdsi-webapi:8080/WebAPI/info; do sleep 5; done

for f in /scripts/*.sql; do
    echo "Running $f"
    sed "s/webapi\./${WEBAPI_DATASOURCE_OHDSI_SCHEMA}./g" "$f" | psql -v ON_ERROR_STOP=1 -q
done
