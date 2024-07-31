FROM debian:bullseye

ARG DN=EMPTY
ENV DOMAIN_NAME=${DN}

# install needed dependencies and latest stable nginx version from official repository
RUN apt update -y && \
    apt install gettext-base curl gnupg2 ca-certificates lsb-release debian-archive-keyring -y && \
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null && \
    gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/debian `lsb_release -cs` nginx" > /etc/apt/sources.list.d/nginx.list && \
    echo "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" > /etc/apt/preferences.d/99nginx && \
    apt update -y && \
    apt install nginx -y

# html files will go in this folder
RUN mkdir -p /var/www/html/${DN}
RUN chmod 777 /var
RUN chmod 777 /var/www
RUN chmod 777 /var/www/html
RUN chmod 777 /var/www/html/${DN}
COPY tools/index.html /var/www/html/${DN}

# replacing the default configuration file by the one i pimped
COPY conf/nginx.conf.template etc/nginx/nginx.conf.template

RUN envsubst "\$DOMAIN_NAME" < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

CMD ["nginx"]






