#!/bin/sh

sleep 3

ip a

cd /var/www/html/${DOMAIN_NAME}

if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    wp config create --dbname="${WP_DB_NAME}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost="mariadb" --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url="${URL}" --title="${TITLE}" --admin_user="${WP_ADMIN_USERNAME}" --admin_password="${WP_ADMIN_PW}" --admin_email="${WP_ADMIN_MAIL}" --skip-email --allow-root
    wp user create "${WP_USER_USERNAME}" "${WP_USER_MAIL}" --role=editor --user_pass="${WP_USER_PW}" --allow-root
    wp plugin install redis-cache --activate --allow-root
    ln -s /var/www/html/dosokin.42.fr/wp-content/plugins/redis-cache/includes/object-cache.php /var/www/html/dosokin.42.fr/wp-content/object-cache.php
    wp redis enable --allow-root
    wp config set WP_REDIS_HOST "redis" --allow-root
    wp config set WP_REDIS_PORT "6379" --allow-root
    wp config set WP_REDIS_DATABASE "15" --allow-root

fi

service php7.4-fpm start
sleep 1
service php7.4-fpm stop
sleep 1
php-fpm7.4
