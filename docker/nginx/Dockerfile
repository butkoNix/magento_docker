FROM nginx:1.9

RUN apt-get update -y \
    && apt-get install -y \
        logrotate \
    && rm -rf /var/lib/apt/lists/*


ENV SERVER_NAME localhost
ENV MAGE_ROOT /var/www
ENV MAGE_MODE production

RUN sed -i 's/user *nginx;/user www-data;/g' /etc/nginx/nginx.conf

COPY nginx.logrotate.conf /etc/logrotate.d/
COPY default.conf.template /
RUN perl -pe \
    's;(\\*)(\$\{([a-zA-Z_][a-zA-Z_0-9]*)\})?;substr($1,0,int(length($1)/2)).($2&&length($1)%2?$2:$ENV{$3});eg' \
    /default.conf.template > /etc/nginx/conf.d/default.conf
