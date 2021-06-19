# EcommPro PHP Docker Images

**NOTICE: 2021-06-19: set `main` as default branch**

**NOTICE: 2021-06-19: dropped support for unmaintained PHP versions: 5.6, 7.0, 7.1 and 7.2**

**NOTICE: tags ending with `-debian` will be deprecated. Please, use the `-fpm` and `-cli` ones (based on debian).**

**NOTICE: dropped support for Alpine-based containers.**

PHP docker images by [EcommPro SL](https://ecomm.pro/) | @ecommprohq | <dev@ecomm.pro>. **Based on the official PHP Debian docker images.**

Ready to use with Magento, Magento 2, WordPress and Laravel.

Pre-built PHP extensions:

    bcmath
    gd
    geoip
    igbinary
    imagick
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

    swoole (disabled by default)
    rdkafka (disabled by default)

Two versions: FPM and CLI.

Images (available from <https://hub.docker.com/u/ecommpro>):

    ecommpro/php:8.0-fpm
    ecommpro/php:8.0-cli
    ecommpro/php:7.4-fpm
    ecommpro/php:7.4-cli
    ecommpro/php:7.3-fpm
    ecommpro/php:7.3-cli
    ecommpro/php:7.2-fpm (deprecated)
    ecommpro/php:7.2-cli (deprecated)
    ecommpro/php:7.1-fpm (deprecated)
    ecommpro/php:7.1-cli (deprecated)
    ecommpro/php:7.0-fpm (deprecated)
    ecommpro/php:7.0-cli (deprecated)
    ecommpro/php:5.6-fpm (deprecated)
    ecommpro/php:5.6-cli (deprecated)

## CLI

CLI Tools included:

    composer.phar
    modman
    n98-magerun.phar
    n98-magerun2.phar
    wp-cli.phar
    jq

System packages included:

    bash
    git
    mariadb-client
    vim
    zsh
    msmtp

```
docker run -u $(id -u):$(id -g) -ti --rm -v $(pwd):/work ecommpro/php:7.4-cli zsh
```

Make PHP Great Again. Happy coding!

## Container-friendly SMTP with MSMTP

```
echo -n "Enter SMTP password: " && read -s SMTP_PASSWORD
export SMTP_PASSWORD

docker run -ti --rm \
    -e SMTP_PASSWORD \
    -e SENDMAIL_COMMAND='msmtp --tls=on --tls-starttls=off --tls-trust-file=/etc/ssl/certs/ca-certificates.crt --host=main.mailer.ecomm.pro --protocol=smtp --auth=on --user=mta@ecomm.pro --passwordeval="printf \"%s\n\" \"$SMTP_PASSWORD\"" --port=465 --read-envelope-from -t' \
ecommpro/php:7.4-cli zsh
```

And then, inside the container:

```
php -r 'mail("manel@ecomm.pro", "Hey, again!", "Come on, again!", "From: hello@ecomm.pro");'
```

Et voilà.

We've included the *msmtp* package in the containers, and set the `sendmail_path` PHP setting to `eval $SENDMAIL_COMMAND`. This way you can configure the mail sending command with environmente variables. **This is not secure for production environments and you should override this configuration by using, for example, mounted volumes**:

```
[docker] ➜  ~ cat /usr/local/etc/php/conf.d/msmtp.ini
sendmail_path = "eval $SENDMAIL_COMMAND"
```

```
docker run -ti --rm \
    -v /dev/null:/usr/local/etc/php/conf.d/msmtp.ini
    -e SMTP_PASSWORD \
    -e SENDMAIL_COMMAND='msmtp --tls=on --tls-starttls=off --tls-trust-file=/etc/ssl/certs/ca-certificates.crt --host=main.mailer.ecomm.pro --protocol=smtp --auth=on --user=mta@ecomm.pro --passwordeval="printf \"%s\n\" \"$SMTP_PASSWORD\"" --port=465 --read-envelope-from -t' \
ecommpro/php:7.4-cli zsh
```

Example using SendGrid:

```
echo -n "Enter SMTP password: " && read -s SMTP_PASSWORD
export SMTP_PASSWORD

docker run -ti --rm \
    -v /dev/null:/usr/local/etc/php/conf.d/msmtp.ini
    -e SMTP_PASSWORD \
    -e SENDMAIL_COMMAND='msmtp --tls=on --tls-starttls=off --tls-trust-file=/etc/ssl/certs/ca-certificates.crt --host=smtp.sendgrid.net --protocol=smtp --auth=on --user=apikey --passwordeval="printf \"%s\n\" \"$SMTP_PASSWORD\"" --port=465 --read-envelope-from -t' \
ecommpro/php:7.4-cli zsh
```

And then, inside the container:

```
php -r 'mail("manel@ecomm.pro", "Hey, again (from SendGrid)!", "Come on, again (from SendGrid)!", "From: mysender@mydomain.tld");'
```

## Project and environment aware shell prompt

By using the PRO_PRJ and PRO_ENV environment variables you can be aware of where you are:

```
docker run -e PRO_ENV=production -e PRO_PRJ=woolr -u $(id -u):$(id -g) -ti --rm -v $(pwd):/work ecommpro/php:7.4-cli zsh
```

```
production|woolr >  ~
➜ 
```
