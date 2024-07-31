FROM debian:bullseye

RUN apt update && \
    apt install mariadb-server gettext-base iproute2 -y

COPY tools/statements.sql.template /usr/share/statements.sql.template

COPY tools/script.sh /usr/share/script.sh

COPY conf/my.cnf /etc/mysql/my.cnf
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod 777 /usr/share/script.sh
CMD ["./usr/share/script.sh"]

