#!/bin/bash

# wait for init to finish
sleep 5

# check if database was already initialized
if [ ! -d "/media/persistent/mysql" ]; then
    mkdir -p /media/persistent/mysql
fi
chmod -R 0700 /media/persistent/mysql
chown mysql:mysql /media/persistent/mysql
mkdir -p /var/run/mysqld
chown mysql:mysql /var/run/mysqld
chown mysql /tmp/mysql.sql
if [ ! -d "/media/persistent/mysql/data" ]; then
    /usr/bin/mysqld_safe --datadir=/media/persistent/mysql/data --initialize --init-file=/tmp/mysql.sql
    /usr/bin/mysql -hlocalhost -uroot -ppassword wordpress < /db/data.sql &>> /tmp/m.log
else
    /usr/bin/mysqld_safe --datadir=/media/persistent/mysql/data --init-file=/tmp/mysql.sql
fi
