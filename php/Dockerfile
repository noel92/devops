FROM php:fpm

RUN sed -i 's|deb.debian.org|mirrors.ustc.edu.cn|g' \
	/etc/apt/sources.list
RUN sed -i 's|security.debian.org|mirrors.ustc.edu.cn/debian-security|g' \
 	/etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng12-dev \
	libmemcached-dev \
	zlib1g-dev

RUN docker-php-ext-configure gd \
	--with-freetype-dir=/usr/include/ \
	--with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure pdo_mysql \
	--with-pdo-mysql=mysqlnd
RUN docker-php-ext-configure pcntl \
	--enable-pcntl
RUN docker-php-ext-install -j$(nproc) \
	gd \
	mcrypt \
	pdo_mysql \
	pcntl

RUN rm -rf /var/html && mkdir /var/html

RUN pecl install memcached \
	&& pecl install redis \
	&& pecl install xdebug \
	&& docker-php-ext-enable memcached redis xdebug
