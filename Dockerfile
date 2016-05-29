FROM ubuntu:16.04
Maintainer Daniel Rudolf von Rohr <d.vonrohr@gmail.com>

# install dependencies
RUN apt-get update && apt-get -y install apache2

EXPOSE 80:80

ENTRYPOINT service apache2 start && bash

