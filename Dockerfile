FROM php:7.4-apache-buster

LABEL maintainer="nimdasx@gmail.com"
LABEL description="Debian Apache PHP7.4 Phalcon4"

#set timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# config php
COPY php-nimdasx.ini /usr/local/etc/php/conf.d/php-nimdasx.ini

# apache
RUN a2enmod rewrite
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/-Indexes/+Indexes/' /etc/apache2/conf-enabled/docker-php.conf

#install dependensi
RUN apt-get -y update \
    && apt-get install -y \
    unzip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pdo_mysql gd \
    && rm -rf /var/lib/apt/lists/*

#install psr (phalcon butuh ini)
WORKDIR /usr/local/src
RUN git clone --depth=1 https://github.com/jbboehr/php-psr.git
WORKDIR /usr/local/src/php-psr
RUN phpize && ./configure && make && make test && make install
#RUN echo extension=psr.so | tee -a /usr/local/etc/php/conf.d/psr.ini
WORKDIR /
RUN rm -rf /usr/local/src/php-psr
#enable psr
RUN docker-php-ext-enable psr

#install phalcon
WORKDIR /usr/local/src
RUN git clone --depth=1 "git://github.com/phalcon/cphalcon.git"
WORKDIR /usr/local/src/cphalcon/build
RUN ./install
WORKDIR /
RUN rm -rf /usr/local/src/cphalcon
#enable phalcon
RUN docker-php-ext-enable phalcon

