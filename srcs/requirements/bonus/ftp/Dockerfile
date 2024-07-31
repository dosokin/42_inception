FROM debian:bullseye

RUN apt update -y && \
    apt install vsftpd iproute2 -y

COPY conf/vsftpd.conf /etc

RUN useradd -ms /bin/bash user
RUN echo "user:password"|chpasswd

RUN echo "user" > /etc/vsftpd.userlist
RUN mkdir -p /home/user/ftp
RUN chmod 777 /home/user
RUN chmod 777 /home/user/ftp

COPY tools/vsftpd.sh /
CMD ["sh", "vsftpd.sh"]
