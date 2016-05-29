FROM ubuntu:16.04
Maintainer Daniel Rudolf von Rohr <d.rudolf.von.rohr@gmail.com>

# install dependencies
RUN apt-get update && apt-get -y install apache2

# install php-7
RUN apt-get install -y php
RUN apt-get install -y libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json php7.0-mcrypt php-mbstring composer

EXPOSE 80:80

ENTRYPOINT service apache2 start && bash

