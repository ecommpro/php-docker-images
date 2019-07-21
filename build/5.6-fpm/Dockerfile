FROM php:5.6-fpm-alpine

RUN set -ex \
&& apk update \
&& apk add $PHPIZE_DEPS git msmtp \
&& docker-php-ext-install bcmath \
\
&& docker-php-ext-install sockets \
\
&& docker-php-ext-install opcache \
\
&& apk add freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
	&& docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install gd \
	&& apk del freetype-dev libpng-dev libjpeg-turbo-dev \
\
&& apk add imagemagick-libs imagemagick-dev \
	&& printf "\n" | pecl install imagick-3.4.4 \
	&& apk del imagemagick-dev \
\
&& apk add libmcrypt-dev \
	&& docker-php-ext-configure mcrypt --with-mcrypt \
	&& docker-php-ext-install mcrypt \
\
&& apk add icu icu-dev \
	&& docker-php-ext-install intl \
	&& apk del icu-dev \
\
&& apk add libxml2-dev \
	&& docker-php-ext-install soap \
	&& CFLAGS=-I/usr/src/php docker-php-ext-install xmlreader \
	&& CFLAGS=-I/usr/src/php docker-php-ext-install xmlwriter \
	&& apk del libxml2-dev \
\
&& apk add libxslt libxslt-dev \
	&& docker-php-ext-install xsl \
	&& apk del libxslt-dev \
\
&& pecl install igbinary-2.0.8 && docker-php-ext-enable igbinary \
\
&& printf "yes\nyes\n" | pecl install redis-4.3.0 && docker-php-ext-enable redis \
\
&& apk add libmemcached zlib-dev libmemcached-dev \
	&& printf "\n" | pecl install memcached-2.2.0 \
	&& docker-php-ext-enable memcached \
	&& apk del zlib-dev libmemcached-dev \
\
&& apk add zlib-dev libzip-dev libzip \
	&& docker-php-ext-install zip \
	&& apk del zlib-dev libzip-dev \
\
&& apk add geoip geoip-dev \
	&& pecl install geoip-1.1.1 \
	&& docker-php-ext-enable geoip \
	&& apk del geoip-dev \
\
&& docker-php-ext-install pdo_mysql \
\
&& docker-php-ext-install mysqli \
\
&& apk add librdkafka librdkafka-dev && pecl install rdkafka-3.1.2 && apk del librdkafka-dev \
\
&& apk add linux-headers && pecl install swoole-2.0.11 && docker-php-ext-enable swoole && apk del linux-headers \
\
&& (\
	pecl install channel://pecl.php.net/xhprof-0.9.4 \
	&& mkdir -p /opt/xhprof \
	&& cd /opt/xhprof/ \	
	&& pecl download channel://pecl.php.net/xhprof-0.9.4 \
	&& tar --strip 1 -xzvf xhprof-0.9.4.tgz \
	&& rm -fr xhprof-0.9.4.tgz \
	&& docker-php-ext-enable xhprof \
) \
\
&& pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug \
\
&& pecl install uopz-2.0.7 \
&& apk del $PHPIZE_DEPS git\
&& rm -fr /var/cache/apk/* /usr/src/* /usr/local/bin/phpdbg /usr/local/bin/php-cgi

RUN echo '\
sendmail_path = "eval $SENDMAIL_COMMAND"\n'\
>> /usr/local/etc/php/conf.d/msmtp.ini

