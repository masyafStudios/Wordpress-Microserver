#!/bin/bash

rm /etc/localtime
cat /app/timezone.txt > /etc/timezone
/usr/sbin/dpkg-reconfigure -f noninteractive tzdata
