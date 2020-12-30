POSTGRES_DATA="guac-postgres-data"

docker rm -f guacamole
docker rm -f guacd
docker rm -f guac-postgres

# Start postgres 
docker run --name guac-postgres \
           -e POSTGRES_DB=guacamole_db \
           -e PGDATA=/var/lib/postgresql/data/pgdata \
           -v $POSTGRES_DATA:/var/lib/postgresql/data/pgdata \
           -d postgres

# Start guacd 
docker run --name guacd -d argos:5000/guacamole/guacd

# Start guacamole client
docker run --name guacamole --link guacd:guacd --link guac-postgres:postgres \
           -e POSTGRES_DATABASE='guacamole_db' \
           -e POSTGRES_USER='guacamole_user' \
           -e POSTGRES_PASSWORD='Z?X>C<VMNB' \
           -d -p 8080:8080 guacamole/guacamole



