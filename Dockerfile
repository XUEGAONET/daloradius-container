FROM ubuntu:20.04

ENV DALO_VERSION 1.2

ENV DEBIAN_FRONTEND noninteractive

ENV MYSQL_USER radius
ENV MYSQL_PASSWORD dalodbpass
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE radius
ENV TZ Asia/Shanghai

COPY entry.sh /

RUN set -ex \
 && chmod 0544 /entry.sh \

 # install and set php
 && apt-get update \
 && apt-get install -y apt-utils \
                    tzdata \
                    apache2 \
                    libapache2-mod-php \
                    net-tools \
                    php \
                    php-common \
                    php-gd \
                    php-curl \
                    php-mail \
                    php-mail-mime \
                    php-db \
                    php-mysql \
                    mariadb-client \
                    libmysqlclient-dev \
                    unzip \
                    wget \
                    vim \
 && apt-get clean \
 && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
 && update-ca-certificates -f \
 && mkdir -p /tmp/pear/cache \
 && wget http://pear.php.net/go-pear.phar \
 && php go-pear.phar \
 && rm go-pear.phar \
 && pear channel-update pear.php.net \
 && pear install -a -f DB \
 && pear install -a -f Mail \
 && pear install -a -f Mail_Mime \
 && wget https://github.com/lirantal/daloradius/archive/${DALO_VERSION}.zip \
 && unzip ${DALO_VERSION}.zip \
 && rm ${DALO_VERSION}.zip \
 && rm -rf /var/www/html/* \
 && mv daloradius-${DALO_VERSION}/* daloradius-${DALO_VERSION}/.htaccess daloradius-${DALO_VERSION}/.htpasswd /var/www/html \
 && mv /var/www/html/library/daloradius.conf.php.sample /var/www/html/library/daloradius.conf.php \
 && chown -R www-data:www-data /var/www/html \
 && chmod 644 /var/www/html/library/daloradius.conf.php

EXPOSE 80

CMD ["/entry.sh"]
