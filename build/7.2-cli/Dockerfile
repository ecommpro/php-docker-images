FROM php:7.2-cli-alpine

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
&& apk add libmcrypt-dev \
	&& pecl install channel://pecl.php.net/mcrypt-1.0.2 \
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
&& pecl install igbinary-3.0.1 && docker-php-ext-enable igbinary \
\
&& printf "yes\nyes\n" | pecl install redis && docker-php-ext-enable redis \
\
&& apk add libmemcached zlib-dev libmemcached-dev \
	&& printf "\n" | pecl install memcached \
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
&& (\
	mkdir -p /opt \
	&& cd /opt \
	&& git clone https://github.com/longxinH/xhprof.git \
	&& mkdir -p /usr/src \
	&& cd /usr/src \
	&& git clone https://github.com/tideways/php-xhprof-extension.git \
	&& cd php-xhprof-extension \
	&& phpize \
	&& ./configure --with-php-config=/usr/local/bin/php-config \
	&& make \
	&& make install \
) \
\
&& pecl install xdebug \
\
&& pecl install uopz-6.1.0 \
&& apk del $PHPIZE_DEPS git\
&& rm -fr /var/cache/apk/* /usr/src/* /usr/local/bin/phpdbg /usr/local/bin/php-cgi
### CLI ###

RUN apk --update add git zsh vim bash

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

RUN echo $'\n'\
$'# \n'\
$'# Welcome to the awesomic PHP-CLI docker image by [EcommPro SL](https://ecomm.pro/) | @ecommprohq | <dev@ecomm.pro>.\n'\
$'# Based on the official php:7.2-cli-alpine docker image.\n'\
$'# \n'\
$'# Pre-built PHP extensions included: bcmath, sockets, opcache, gd, mcrypt, intl, xmlrw, xsl, igbinary, redis, memcached, zip, geoip, pdo_mysql, mysqli, xhprof, xdebug, uopz.\n'\
$'# \n'\
$'# Tools included: composer.phar, modman, n98-magerun.phar, n98-magerun2.phar, wp-cli.phar.\n'\
$'# \n'\
$'# Make PHP Great Again. Happy coding!\n'\
$'# \n'\
$'# Check <https://github.com/ecommpro/php-docker-images/blob/master/README.md> for more information.\n'\
$'# \n'\
$''\
>> /etc/motd.ecommpro

RUN echo $'\
cat /etc/motd.ecommpro\n\
export HOME=/work\n\
export COMPOSER_HOME=/usr/local/share/composer\n\
export COMPOSER_CACHE_DIR=~/.local/composer/cache\n\
export PATH=$HOME/.local/bin:/opt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\n\
export ZSH=/usr/local/share/oh-my-zsh\n\
ZSH_THEME="robbyrussell"\n\
plugins=(\n\
  git\n\
)\n\
ZDOTDIR=/local\n\
HISTFILE=${ZDOTDIR}/.zsh_history\n\
source $ZSH/oh-my-zsh.sh\n\
export PS1="[docker] $PS1"\n'\
>> /etc/zsh/zshrc
