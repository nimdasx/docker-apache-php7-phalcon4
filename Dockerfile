FROM php:7.4-apache-bullseye

LABEL maintainer="nimdasx@gmail.com" \
    description="apache php-7.4 phalcon-4.1"

#ioncube
COPY ioncube /usr/src/ioncube
RUN mkdir /usr/local/ioncube \
    && mv /usr/src/ioncube/$(uname -m)/ioncube_loader_lin_7.4.so /usr/local/ioncube \
    && mv /usr/src/ioncube/php-ioncube.ini /usr/local/etc/php/conf.d

#config php
COPY php-nimdasx.ini /usr/local/etc/php/conf.d/php-nimdasx.ini

#config apache
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

#timezone, apache
RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
    && a2enmod rewrite remoteip headers \
    && sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/-Indexes/+Indexes/' /etc/apache2/conf-enabled/docker-php.conf

# x
# Dependencies for PHP extensions:
# - GD: libfreetype6-dev, libjpeg62-turbo-dev, libpng-dev
# - PostgreSQL (pdo_pgsql): libpq-dev
# - XML-RPC: libxml2-dev
# - ZIP: libzip-dev
# dihapus
# gcc \
# g++ \
# make \
# autoconf \
# libpcre3-dev \
# pkg-config \
# re2c \
# zip \
RUN apt-get -y update \
    && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libpq-dev \
    libxml2-dev \
    libzip-dev \
    mariadb-client \
    libc-dev \
    && echo "configure dan install" \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql pdo_pgsql gd zip mysqli xmlrpc \
    && echo "hapus" \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/pear

#redis, gak butuh apt apapun
#psr, phalcon 4 harus pakai ext ini, gak butuh apt apapun
#phalcon, gak butuh apt apapun
RUN pecl channel-update pecl.php.net \
    && pecl install redis psr-1.2.0 \
    && pecl install phalcon-4.1.2 \
    && docker-php-ext-enable redis psr phalcon \
    && echo "hapus" \
    && rm -rf /tmp/pear

#sqlsrv
#RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
#    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
#    && apt-get update \
#    && ACCEPT_EULA=Y apt-get install -y \
#    msodbcsql17 \
#    mssql-tools \
#    unixodbc-dev \
#    libgssapi-krb5-2 \
#    && rm -rf /var/lib/apt/lists/* \
#    && pecl install sqlsrv pdo_sqlsrv \
#    && docker-php-ext-enable sqlsrv pdo_sqlsrv \
#    && sed -i 's/TLSv1.2/TLSv1.0/g' /etc/ssl/openssl.cnf
