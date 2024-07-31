#!/bin/bash

ip a
envsubst '\$WP_DB_NAME \$MYSQL_USER \$MYSQL_PASSWORD' < /usr/share/statements.sql.template > /usr/share/statements.sql
service mariadb start
mariadb -u root < /usr/share/statements.sql
service mariadb stop
mariadbd