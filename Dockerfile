FROM ubuntu:20.04

ENV DALO_VERSION 1.3

ENV DEBIAN_FRONTEND noninteractive

ENV MYSQL_USER radius
ENV MYSQL_PASSWORD dalodbpass
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DATABASE radius
ENV TZ Asia/Shanghai

COPY entry.sh /

# PHP install
RUN apt-get update \
	&& apt-get install --yes --no-install-recommends \
		ca-certificates \
		apt-utils \
		freeradius-utils \
		tzdata \
		apache2 \
		libapache2-mod-php \
		cron \
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
	&& rm -rf /var/lib/apt/lists/*

# Create daloRADIUS Log file
RUN touch /var/log/daloradius.log && chown -R www-data:www-data /var/log/daloradius.log

RUN set -ex \
 && chmod 0544 /entry.sh \
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


