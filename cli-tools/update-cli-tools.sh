#!/bin/sh
TO=${TO:-$(pwd)}
mkdir -p $TO

(

cd $TO

# PHP tools

curl -o composer.phar https://getcomposer.org/composer.phar \
    && chmod +x composer.phar \
    && ln -sf composer.phar composer

# Magento 1.x tools

curl -o modman https://raw.githubusercontent.com/colinmollenhour/modman/master/modman \
    && chmod +x modman

curl -o n98-magerun.phar https://files.magerun.net/n98-magerun.phar \
    && chmod +x n98-magerun.phar \
    && ln -sf n98-magerun.phar n98-magerun

# Magento 2.x tools

curl -o n98-magerun2.phar https://files.magerun.net/n98-magerun2.phar \
    && chmod +x n98-magerun2.phar \
    && ln -sf n98-magerun2.phar n98-magerun2

# WordPress tools

curl -o wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && ln -sf wp-cli.phar wp \
    && ln -sf wp-cli.phar wp-cli

tar --exclude=update.sh -czf ../cli-tools.tgz .

)
