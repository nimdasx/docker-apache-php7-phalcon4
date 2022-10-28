# docker apache php 7 phalcon 4

## catatanx
````
docker build --tag nimdasx/sf-phalcon4 .
docker run -d -p 81:80 -v /Users/sofyan/Dev/php:/var/www/html --name terserah nimdasx/sf-phalcon4
docker rm -f terserah
docker push nimdasx/sf-phalcon4
````

## build dan push ke github :
````
docker build --tag ghcr.io/nimdasx/docker-apache-php7-phalcon4:master .
docker push ghcr.io/nimdasx/docker-apache-php7-phalcon4:master
````

## build dan push ke docker hub :
````
docker buildx create --name jangkrik --use --bootstrap
docker buildx build --push --platform linux/amd64,linux/arm64 --tag nimdasx/apache-php7-phalcon4 .
````