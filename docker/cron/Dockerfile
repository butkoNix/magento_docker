FROM nixteam/php:7.0.10-dev

# gpg: key 5072E1F5: public key "MySQL Release Engineering <mysql-build@oss.oracle.com>" imported
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5
RUN echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.7" > /etc/apt/sources.list.d/mysql.list

ADD crontab /crontab.www-data
ADD start.sh /start.sh

RUN apt-get update && apt-get install -y --force-yes cron rsyslog mysql-client && apt-get clean
RUN crontab -u www-data /crontab.www-data; \
  chmod +x /start.sh; \
  touch /var/log/cron.log

CMD ["/start.sh"]
