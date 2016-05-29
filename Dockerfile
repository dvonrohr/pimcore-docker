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

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini

# get pimcore source
# run mkdir /var/www/html/pimcore
# WORKDIR /var/www/html/pimcore
# RUN composer create-project pimcore/pimcore .
# RUN composer dumpautoload -o

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

ADD www /var/www/html/pimcore

# set filesystem permissions
# RUN chown -R www-data:www-data website/var pimcore plugins

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

EXPOSE 80

ADD start.sh /start.sh
RUN chmod 0755 /start.sh
CMD ["bash", "start.sh"]

