# docker apache php-7.4 phalcon-4.1

## catatan
- phalcon 4.1 maksimal di php 7.4
- bullseye : berhasil arm64, amd64
- buster : berhasil arm64, amd64
- bullesye berhasil arm64 karene tambahan paket     
    gcc \
    g++ \
    make \
    autoconf \
    automake \
    libpcre3-dev \
    pkg-config \
    re2c \

## command
````
# run
docker run -d -p 81:80 -v /Users/sofyan/Dev/php:/var/www/html --name dinosaurus nimdasx/apache-php7-phalcon4

# build
docker build --tag nimdasx/apache-php7-phalcon4 . 

# push ke docker hub
docker image push nimdasx/apache-php7-phalcon4

# create buildx
docker buildx create --name jangkrik --use --bootstrap

# jika error pas buildx, jalankan ini
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

# buildx and push ke github
docker buildx build --push --platform linux/amd64,linux/arm64 --tag ghcr.io/nimdasx/apache-php7-phalcon4 .

# buildx and push ke docker hub
docker buildx build --push --platform linux/amd64,linux/arm64 --tag nimdasx/apache-php7-phalcon4 .
````