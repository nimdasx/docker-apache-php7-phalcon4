# Debian Apache PHP7.4 Phalcon4
## contoh cara pakai
hidupkan  
`docker run -d -p 81:80 -v d:/dev/php:/var/www/html --name terserah nimdasx/sf-phalcon4`  
matikan  
`docker rm -f terserah`
## catatan pribadi (abaikan)
````
docker build --tag nimdasx/sf-phalcon4 . 
docker push nimdasx/sf-phalcon4
````