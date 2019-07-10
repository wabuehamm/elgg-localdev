#!/usr/bin/env sh

echo "Waiting for db to come up"

wait4ports tcp://db:3306

echo "Loading database"

mysql --user=mitglieder --password=mitglieder --host=db --protocol=tcp --database=mitglieder --execute='source /db/dump.sql' 

echo "Recreating certificate"

printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth" > config

openssl req -x509 -out /etc/ssl/apache2/server.pem -keyout /etc/ssl/apache2/server.key \
    -newkey rsa:2048 -nodes -sha256 \
    -subj '/CN=localhost' -extensions EXT -config config

echo "Starting web service"

/usr/sbin/httpd

tail -f /var/log/apache2/*.log
