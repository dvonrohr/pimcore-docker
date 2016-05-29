FROM ubuntu:16.04
Maintainer Daniel Rudolf von Rohr <d.rudolf.von.rohr@gmail.com>

# install dependencies
RUN apt-get update && apt-get -y install apache2

# install php-7
RUN apt-get install -y php unzip
RUN apt-get install -y libapache2-mod-php7.0 php7.0-mysql php-bz2 php-gd php-zip php-xml php7.0-curl php7.0-json php7.0-mcrypt php-mbstring composer

# set up virtual host
RUN a2enmod rewrite
RUN rm /etc/apache2/sites-available/000-default.conf
ADD pimcore.conf /etc/apache2/sites-available/000-default.conf
# RUN a2ensite pimcore.conf

# get pimcore source
run mkdir /var/www/html/pimcore
WORKDIR /var/www/html/pimcore
RUN composer create-project pimcore/pimcore .
RUN composer dumpautoload -o

# set filesystem permissions
RUN chown -R www-data:www-data website/var pimcore plugins

EXPOSE 80:80

ENTRYPOINT service apache2 start && bash

