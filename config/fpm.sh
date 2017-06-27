#!/bin/bash

# wait for init to finish
sleep 5

/usr/sbin/php-fpm7.0 --nodaemonize
