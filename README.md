# EcommPro PHP Docker Images

Welcome to the awesomic PHP docker images by [EcommPro SL](https://ecomm.pro/) | @ecommprohq | <dev@ecomm.pro>. **Based on the official PHP alpine docker images.**

Ready to use with Magento, Magento 2, Wordpress and Laravel.

Pre-built PHP extensions:
    
    bcmath
    gd
    geoip
    igbinary
    intl
    mcrypt
    memcached
    mysqli
    opcache
    pdo_mysql
    redis
    sockets
    xmlrw
    xsl
    zip

    uopz (disabled by default)
    xdebug (disabled by default)
    xhprof (disabled by default)


Two flavors: FPM and CLI.

Images:

    ecommpro/php:5.6-cli
    ecommpro/php:5.6-fpm
    ecommpro/php:7.0-cli
    ecommpro/php:7.0-fpm
    ecommpro/php:7.1-cli
    ecommpro/php:7.1-fpm
    ecommpro/php:7.2-cli
    ecommpro/php:7.2-fpm
    ecommpro/php:7.3-cli
    ecommpro/php:7.3-fpm

## CLI

CLI Tools included:

    composer.phar
    modman
    n98-magerun.phar
    n98-magerun2.phar
    wp-cli.phar

System packages included:
    
    bash
    git
    mariadb-client
    vim
    zsh

```
docker run -u $(id -u):$(id -g) -ti --rm -v $(pwd):/work ecommpro/php:7.3-cli zsh
```

Make PHP Great Again. Happy coding!