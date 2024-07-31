FROM debian:bullseye

# install needed dependencies and latest stable nginx version from official repository
RUN apt update -y && \
    apt install wget gettext-base curl gnupg2 ca-certificates lsb-release debian-archive-keyring -y && \
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null && \
    gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/debian `lsb_release -cs` nginx" > /etc/apt/sources.list.d/nginx.list && \
    echo "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" > /etc/apt/preferences.d/99nginx && \
    apt update -y && \
    apt install nginx -y

# adminer file will go here
RUN mkdir -p /var/www/html/adminer && chmod 777 /var/www/html/adminer
RUN cd /var/www/html/adminer && wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php -O adminer.php
RUN chmod 777 /var
RUN chmod 777 /var/www
RUN chmod 777 /var/www/html
RUN chmod 777 /var/www/html/adminer
RUN chmod 777 /var/www/html/adminer/adminer.php
# replacing the default configuration file by the one i pimped
COPY conf/nginx.conf etc/nginx/nginx.conf

CMD ["nginx"]
