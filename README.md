# docker apache php-7.4 phalcon-4.1
## catatan
````
docker run -d -p 81:80 -v /Users/sofyan/Dev/php:/var/www/html --name dinosaurus nimdasx/apache-php7-phalcon4
docker buildx create --name jangkrik --use --bootstrap
````
## build dan push ke github
````
docker buildx build --push --platform linux/amd64,linux/arm64 --tag ghcr.io/nimdasx/apache-php7-phalcon4 .
````
## build dan push ke docker hub
````
docker buildx build --push --platform linux/amd64,linux/arm64 --tag nimdasx/apache-php7-phalcon4 .
````