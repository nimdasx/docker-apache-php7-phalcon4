# docker apache php-7.4 phalcon-4.1

## catatan
- phalcon 4.1 maksimal di php 7.4
- multibuilder lokal dan remote cek https://github.com/nimdasx/gits/blob/main/docker.md#lokal-builder-for-amd64-remote-builder-for-arm64

## command
````
# buildx and push ke github
docker buildx build --platform linux/amd64,linux/arm64 --tag ghcr.io/nimdasx/apache-php7-phalcon4 --push .

# buildx and push ke docker hub
docker buildx build --platform linux/amd64,linux/arm64 --tag nimdasx/apache-php7-phalcon4 --push .
````