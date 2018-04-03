#!/usr/bin/env bash

# AllowOverride to All

sed -i 's,AllowOverride None,AllowOverride All,g' /etc/httpd/conf/httpd.conf

start-servers
bash /usr/sbin/setup-mysql-user

# Import database dump

mysqlshow -u root | grep ${MYSQL_DATABASE} &>/dev/null

if [ $? -ne 0 ]
then
    echo "Importing database dump"

    mysqladmin -u root create ${MYSQL_DATABASE}
    mysql -u root ${MYSQL_DATABASE} < /db/dump.sql

    echo "Done."

fi

echo "Ready."

sleep infinity
