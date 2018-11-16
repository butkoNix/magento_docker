#!/bin/bash

env >> /etc/environment
rsyslogd
cron
tail -f /var/log/syslog /var/log/cron.log
