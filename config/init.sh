#!/bin/bash

# initialize logging directory
mkdir -p /media
mkdir -p /media/persistent

# make sure the log folder and web folders exists
mkdir -p /media/persistent/log
mkdir -p /media/persistent/web

# make the log folder owned by www-data
chown -R www-data /media/persistent/log
chgrp -R www-data /media/persistent/log
chmod -R g+rw /media/persistent/log

chown -R www-data /media/persistent/web
chgrp -R www-data /media/persistent/web
chmod -R g+rw /media/persistent/web

# make sure new sub-folders have the correct permissions
find /media/persistent -type d -exec chmod 2775 {} \;
find /media/persistent -type f -exec chmod ug+rw {} \;

exit 0
