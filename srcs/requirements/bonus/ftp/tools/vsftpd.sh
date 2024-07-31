#!/bin/bash

sleep 1

service vsftpd start
service vsftpd status
service vsftpd stop

vsftpd /etc/vsftpd.conf