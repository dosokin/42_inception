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

COPY tools/openssl.cnf.template /etc/ssl/openssl.cnf.template

RUN envsubst "\$DOMAIN_NAME" < /etc/ssl/openssl.cnf.template > /etc/ssl/openssl.cnf

# install openssl
RUN apt install openssl -y
# gen private key
RUN openssl genrsa -out /etc/ssl/private/server.key 2048
# gen certificate signing request with infos infos from openssl.cnf
RUN openssl req -new -key /etc/ssl/private/server.key -out /etc/ssl/server.csr -config /etc/ssl/openssl.cnf
# self sign the certificate
RUN openssl x509 -req -days 365 -in /etc/ssl/server.csr -signkey /etc/ssl/private/server.key -out /etc/ssl/server.crt

# files from volume will go in this folder
RUN mkdir -p /var/www/html/${DN}

# replacing the default configuration file by the one i pimped
COPY conf/nginx.conf.template etc/nginx/nginx.conf.template

RUN envsubst "\$DOMAIN_NAME" < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

CMD ["nginx"]






