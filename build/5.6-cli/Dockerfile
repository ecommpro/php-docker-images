FROM php:5.6-cli
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
	&& docker-php-ext-configure mcrypt --with-mcrypt \
	&& docker-php-ext-install mcrypt \
\
&& apt-get install --no-install-recommends -y libsodium18 libsodium-dev \
	&& pecl install libsodium-1.0.7 \
	&& apt-get --purge remove -y libsodium-dev \
\
&& apt-get install --no-install-recommends -y libicu57 libicu-dev \
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
&& pecl install igbinary-2.0.8 && docker-php-ext-enable igbinary \
\
&& printf "yes\nyes\n" | pecl install redis-4.3.0 && docker-php-ext-enable redis \
\
&& apt-get install --no-install-recommends -y libmemcached11 libmemcachedutil2 zlib1g-dev libmemcached-dev \
	&& printf "\n" | pecl install memcached-2.2.0 \
	&& docker-php-ext-enable memcached \
	&& apt-get --purge remove -y zlib1g-dev libmemcached-dev \
\
&& apt-get install --no-install-recommends -y zlib1g-dev libzip-dev libzip4 \
	&& docker-php-ext-install zip \
	&& apt-get --purge remove -y zlib1g-dev libzip-dev \
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
&& pecl install swoole-2.0.11 \
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
&& apt-get --purge remove -y git \
&& apt-get --purge autoremove -y \
&& apt-get clean \
&& rm -fr /usr/src

RUN echo '\
sendmail_path = "eval $SENDMAIL_COMMAND"\n'\
>> /usr/local/etc/php/conf.d/msmtp.ini

### CLI ###

RUN apt-get update && apt-get install --no-install-recommends -y git zsh vim bash mariadb-client unzip wget less iputils-ping && apt-get clean

RUN mkdir -p /work /local /opt/bin /etc/zsh && chmod 777 /work /local
WORKDIR /work

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git /usr/local/share/oh-my-zsh

COPY cli-tools /usr/local/bin

RUN mkdir -p /usr/local/share/composer
RUN COMPOSER_HOME=/usr/local/share/composer && ( \
  composer global require hirak/prestissimo \
  && composer clearcache \
  && find /usr/local/share/composer -type d -exec chmod 777 {} \; \
  && find /usr/local/share/composer -type f -exec chmod 666 {} \; \
)

RUN echo \
'\n'\
'# \n'\
'# Welcome to the awesomic PHP-CLI docker image by [EcommPro SL](https://ecomm.pro/) | @ecommprohq | <dev@ecomm.pro>.\n'\
'# Based on the official php:5.6-cli docker image.\n'\
'# \n'\
'# Pre-built PHP extensions included: bcmath, sockets, opcache, gd, imagick, mcrypt, libsodium, intl, xmlrw, xsl, igbinary, redis, memcached, zip, geoip, pdo_mysql, mysqli, rdkafka, swoole, xhprof, xdebug, uopz.\n'\
'# \n'\
'# Tools included: composer.phar, modman, n98-magerun.phar, n98-magerun2.phar, wp-cli.phar.\n'\
'# \n'\
'# Make PHP Great Again. Happy coding!\n'\
'# \n'\
'# Check <https://github.com/ecommpro/php-docker-images/blob/master/README.md> for more information.\n'\
'# \n'\
''\
>> /etc/motd.ecommpro

COPY etc/zshrc /etc/zsh/zshrc
