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
	libpng12-dev

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

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php \
 	&& php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/bin/composer.phar \
    && echo "#! /bin/sh\nphp /usr/bin/composer.phar \$*" > /usr/bin/composer \
	&& chmod +x /usr/bin/composer
RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com
