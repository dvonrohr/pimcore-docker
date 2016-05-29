# Readme.md

## Build container
docker build -t dvonrohr/pimcore .

## Run image

docker run --name pimcore-mysql -e MYSQL_ROOT_PASSWORD=root -d mysql

docker run --name pimcore-sandbox --link pimcore-mysql:mysql -it -p 8080:80 dvonrohr/pimcore /bin/bash
