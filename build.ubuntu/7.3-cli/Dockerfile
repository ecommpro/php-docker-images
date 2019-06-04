FROM php:7.3-cli
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
	&& printf "\n" | pecl install channel://pecl.php.net/mcrypt-1.0.2 \
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
&& pecl install igbinary-3.0.1 && docker-php-ext-enable igbinary \
\
&& printf "yes\nyes\n" | pecl install redis && docker-php-ext-enable redis \
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
&& apt-get install --no-install-recommends -y libgeoip1 libgeoip-dev \
	&& pecl install geoip-1.1.1 \
	&& docker-php-ext-enable geoip \
	&& apt-get --purge remove -y libgeoip-dev \
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
&& pecl install xdebug-2.7.2 \
\
&& pecl install uopz-6.1.0 \
&& apt-get --purge remove -y git \
&& apt-get --purge autoremove -y \
&& apt-get clean \
&& rm -fr /usr/src

RUN echo '\
sendmail_path = "eval $SENDMAIL_COMMAND"\n'\
>> /usr/local/etc/php/conf.d/msmtp.ini

### CLI ###

RUN apt-get update && apt-get install --no-install-recommends -y git zsh vim bash mariadb-client && apt-get clean

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
'# Based on the official php:7.3-cli docker image.\n'\
'# \n'\
'# Pre-built PHP extensions included: bcmath, sockets, opcache, gd, imagick, mcrypt, intl, xmlrw, xsl, igbinary, redis, memcached, zip, geoip, pdo_mysql, mysqli, xhprof, xdebug, uopz.\n'\
'# \n'\
'# Tools included: composer.phar, modman, n98-magerun.phar, n98-magerun2.phar, wp-cli.phar.\n'\
'# \n'\
'# Make PHP Great Again. Happy coding!\n'\
'# \n'\
'# Check <https://github.com/ecommpro/php-docker-images/blob/master/README.md> for more information.\n'\
'# \n'\
''\
>> /etc/motd.ecommpro

RUN echo '\
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
