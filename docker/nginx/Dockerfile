FROM nginx:1.9
RUN adduser --disabled-password --gecos '' higher \
    && usermod -d /home/www-data higher \
    && usermod -s /bin/bash higher

RUN apt-get update -y \
    && apt-get install -y \
        logrotate \
    && rm -rf /var/lib/apt/lists/*


ENV SERVER_NAME localhost
ENV MAGE_ROOT /var/www
ENV MAGE_MODE developer

RUN sed -i 's/user *nginx;/user higher;/g' /etc/nginx/nginx.conf

COPY nginx.logrotate.conf /etc/logrotate.d/
COPY default.conf.template /
RUN perl -pe \
    's;(\\*)(\$\{([a-zA-Z_][a-zA-Z_0-9]*)\})?;substr($1,0,int(length($1)/2)).($2&&length($1)%2?$2:$ENV{$3});eg' \
    /default.conf.template > /etc/nginx/conf.d/default.conf
