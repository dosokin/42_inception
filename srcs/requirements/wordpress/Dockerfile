FROM debian:bullseye

ARG DN=EMPTY

#install all php dependencies and get wordpress from the official repository
RUN apt update -y
RUN apt install wget php php-common php-fpm php-mysql wget php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php-imagick php-redis iproute2 -y
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
RUN mkdir -p /var/www/html/${DN} && cd /var/www/html/${DN} && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && cd wordpress && mv * ../ && rm -rf wordpress latest.tar.gz

# php-fpm listen on port 9000
RUN sed -i -e 's/listen = \/run\/php\/php7.4-fpm.sock/listen = wordpress:9000/g' /etc/php/7.4/fpm/pool.d/www.conf
# php-fpm running on foreground
RUN sed -i -e 's/;daemonize = yes/daemonize = no/g' etc/php/7.4/fpm/php-fpm.conf

RUN chmod 777 /var/www/html/${DN}

COPY tools/wp_start.sh .

CMD ["sh", "wp_start.sh"]

