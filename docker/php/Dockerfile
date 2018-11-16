FROM php:7.0.10-fpm

RUN adduser --disabled-password --gecos '' higher

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -y nodejs libmcrypt-dev libpng12-dev libfreetype6-dev libjpeg62-turbo-dev \
libxml2-dev libxslt-dev zlib1g-dev libicu-dev g++ git
RUN npm install --global postcss-cli autoprefixer bower

RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd mbstring mcrypt pcntl pdo_mysql soap intl xsl zip

COPY magento.ini /usr/local/etc/php/conf.d/
COPY session.ini /usr/local/etc/php/conf.d/

RUN mkdir /home/www-data \
    && chown higher:www-data /home/www-data \
    && usermod -d /home/www-data higher \
    && usermod -s /bin/bash higher

ADD http://xdebug.org/files/xdebug-2.4.0rc4.tgz /
RUN tar -xvzf /xdebug-2.4.0rc4.tgz \
    && cd xdebug-2.4.0RC4 \
    && phpize && \
    ./configure \
    && make \
    && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012/

COPY xdebug.ini /usr/local/etc/php/conf.d/
RUN docker-php-ext-enable xdebug

RUN curl -s https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

WORKDIR /var/www

VOLUME /var/www
