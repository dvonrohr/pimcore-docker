FROM alpine:latest

RUN apk --update --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
	php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype \
	php7-mbstring php7-gd php7-bz2 php7-exif php7-fileinfo php7-iconv \
	php7-mcrypt php7-opcache php7-zip php7-zlib nginx supervisor curl && rm /var/cache/apk/*

# Configure composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

