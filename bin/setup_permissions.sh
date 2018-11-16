#!/usr/bin/env bash

# setups www-data as owner-group
chown -R :www-data ./
# setup permissions for files as rw- for owner, ro-- for www-data group and --- to the others
find ./* -type f -exec chmod 660 {} +
# setup permissions for directories as rwx for owner, r-x for www-data group, --- for the others
# # with setuid and setgid bits (first '6')
# for root directory
chmod ug+s .
# and for other directories
find ./* -type d -exec chmod 6770 {} +
# setup +x for shell-files
find ./* -type f -regex ".*\.sh" -exec chmod 770 {} +

# setup special permissions for www-data to write into specific directories
#chmod -R g+w ./app/etc ./pub/media ./pub/static ./var