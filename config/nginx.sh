#!/bin/bash

# wait for init to finish
sleep 5

# web content permissions
chown www-data /app --recursive
chgrp www-data /app --recursive

/usr/sbin/nginx -g "daemon off;"
