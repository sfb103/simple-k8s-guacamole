#!/bin/bash

POSTGRES_DATA="/volumes/guac-postgres"

docker rm -f guacamole
docker rm -f guacd
docker rm -f guac-postgres

# Pull the guacamole (and related) docker images
docker pull guacamole/guacd
docker pull guacamole/guacamole
docker pull postgres 

# Ensure our POSTGRES_DATA path exists as expected
mkdir -f $POSTGRES_DATA

# Create script to prepare postgres database
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > initdb.sql

# Init postgres database
docker run --name guac-postgres \
           -e POSTGRES_DB=guacamole_db \
           -e PGDATA=/var/lib/postgresql/data/pgdata \
           -v $(pwd):/tmp/scripts \
           -v $POSTGRES_DATA:/var/lib/postgresql/data/pgdata \
           -d postgres
sleep 5
docker exec -u postgres -it guac-postgres /bin/bash -c "cat /tmp/scripts/initdb.sql | psql -d guacamole_db -f -"
docker exec -u postgres -it guac-postgres /bin/bash -c "cat /tmp/scripts/inituser.sql | psql -d guacamole_db -f -"

exit





