#!/bin/bash

chown -R www-data:www-data /var/www/html/pimcore/website/var /var/www/html/pimcore/pimcore /var/www/html/pimcore/plugins

# start apache
/usr/sbin/apache2 -D FOREGROUND

