#!/bin/bash

# wait for mysql to start
if [ ! -d "/media/persistent/mysql/data" ]; then
    sleep 30
    /usr/bin/mysql -hlocalhost -uroot -ppassword wordpress < /db/data.sql
fi
