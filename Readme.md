# Readme.md

## Build container
docker build -t dvonrohr/pimcore .

## Run image


### Data volume container
docker create -v /var/www/html/pimcore --name pimcore-data debian:jessie /bin/true

docker run --name pimcore-mysql -e MYSQL_ROOT_PASSWORD=root -d mysql

docker run --name pimcore-sandbox --link pimcore-mysql:mysql -it -p 8080:80 --volumes-from pimcore-data dvonrohr/pimcore /bin/bash
