FROM php:7.4-apache-bullseye

LABEL maintainer="nimdasx@gmail.com" \
    description="apache php-7.4 phalcon-4.1"

#config php
COPY php-nimdasx.ini /usr/local/etc/php/conf.d/php-nimdasx.ini

#config apache
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

#timezone, apache
RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
    && a2enmod rewrite remoteip headers \
    && sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/-Indexes/+Indexes/' /etc/apache2/conf-enabled/docker-php.conf

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions ioncube_loader pdo_mysql pdo_pgsql gd zip mysqli xmlrpc psr redis sqlsrv pdo_sqlsrv phalcon-4.1.2