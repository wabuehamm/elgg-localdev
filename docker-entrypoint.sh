#!/usr/bin/env sh

echo "Waiting for db to come up"

wait4ports tcp://db:3306

EXISTING_TABLES=`mysql --user=mitglieder --password=mitglieder --host=db --protocol=tcp --database=mitglieder --silent --skip-column-names --execute='show tables' | wc -l`

if [ $EXISTING_TABLES -eq 0 ]
then
    echo "Loading database"

    mysql --user=mitglieder --password=mitglieder --host=db --protocol=tcp --database=mitglieder --execute='source /db/dump.sql' 
fi

echo "Recreating certificate"

printf "[dn]\nCN=web\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:web\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth" > config

openssl req -x509 -out /etc/ssl/apache2/server.pem -keyout /etc/ssl/apache2/server.key \
    -newkey rsa:2048 -nodes -sha256 \
    -subj '/CN=web' -extensions EXT -config config

echo "Starting web service"

/usr/sbin/httpd

tail -f /var/log/apache2/*.log
