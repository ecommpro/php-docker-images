FROM php:7.3-fpm
RUN set -ex \
&& apt-get update \
&& apt-get install --no-install-recommends -y git msmtp \
&& docker-php-ext-install bcmath \
\
&& docker-php-ext-install sockets \
\
&& docker-php-ext-install opcache \
\
&& apt-get install --no-install-recommends -y libfreetype6 libfreetype6-dev libpng16-16 libpng-dev libjpeg62-turbo libjpeg62-turbo-dev libjpeg-dev \
	&& docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install gd \
	&& apt-get --purge remove -y libfreetype6-dev libpng-dev libjpeg62-turbo-dev libjpeg-dev \
\
&& apt-get install --no-install-recommends -y imagemagick libmagickwand-dev \
	&& pecl install imagick-3.4.4 \
	&& apt-get --purge remove -y libmagickwand-dev \
\
&& apt-get install --no-install-recommends -y libmcrypt4 libmcrypt-dev \
	&& printf "\n" | pecl install channel://pecl.php.net/mcrypt-1.0.4 \
\
&& apt-get install --no-install-recommends -y libsodium23 libsodium-dev \
	&& pecl install libsodium-2.0.21 \
	&& apt-get --purge remove -y libsodium-dev \
\
&& apt-get install --no-install-recommends -y libicu63 libicu-dev \
	&& docker-php-ext-install intl \
	&& apt-get --purge remove -y libicu-dev \
\
&& apt-get install --no-install-recommends -y libxml2-dev \
	&& docker-php-ext-install soap \
	&& CFLAGS=-I/usr/src/php docker-php-ext-install xmlreader \
	&& CFLAGS=-I/usr/src/php docker-php-ext-install xmlwriter \
	&& apt-get --purge remove -y libxml2-dev \
\
&& apt-get install --no-install-recommends -y libxslt1-dev libxslt1.1 \
	&& docker-php-ext-install xsl \
	&& apt-get --purge remove -y libxslt1-dev \
\
&& pecl install igbinary-3.2.3 && docker-php-ext-enable igbinary \
\
&& printf "yes\nyes\n" | pecl install redis-5.3.4 && docker-php-ext-enable redis \
\
&& apt-get install --no-install-recommends -y libmemcached11 libmemcachedutil2 zlib1g-dev libmemcached-dev \
	&& printf "\n" | pecl install memcached \
	&& docker-php-ext-enable memcached \
	&& apt-get --purge remove -y zlib1g-dev libmemcached-dev \
\
&& apt-get install --no-install-recommends -y zlib1g-dev libzip-dev libzip4 \
	&& docker-php-ext-install zip \
	&& apt-get --purge remove -y zlib1g-dev libzip-dev \
\
&& docker-php-ext-install pcntl \
\
&& apt-get install --no-install-recommends -y libgeoip1 libgeoip-dev \
	&& pecl install geoip-1.1.1 \
	&& docker-php-ext-enable geoip \
	&& apt-get --purge remove -y libgeoip-dev \
\
&& docker-php-ext-install pdo_mysql \
\
&& docker-php-ext-install mysqli \
\
&& apt-get install --no-install-recommends -y librdkafka1 librdkafka-dev \
	&& pecl install rdkafka-3.1.2 \
	&& apt-get --purge remove -y librdkafka-dev \
\
&& apt-get install --no-install-recommends -y libpq5 libpq-dev openssl libssl-dev \
	&& printf "yes\nyes\nyes\nyes\nyes\n" | pecl install swoole-4.4.3 \
	&& apt-get --purge remove -y libpq-dev libssl-dev \
\
&& (\
	pecl install xhprof \
	&& docker-php-ext-enable xhprof \
) \
\
&& pecl install xdebug-3.0.4 && docker-php-ext-enable xdebug \
\
&& pecl install uopz-6.1.0 \
&& apt-get --purge remove -y git \
&& apt-get --purge autoremove -y \
&& apt-get clean \
&& rm -fr /usr/src

RUN echo '\
sendmail_path = "eval $SENDMAIL_COMMAND"\n'\
>> /usr/local/etc/php/conf.d/msmtp.ini

