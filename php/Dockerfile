FROM php:7.1-fpm

RUN apt-get update
RUN apt-get install -y \
	git \
	zip \
	unzip \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng-dev \
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
	pcntl \
	zip

RUN pecl install memcached \
	&& pecl install redis \
	&& pecl install xdebug \
	&& docker-php-ext-enable memcached redis xdebug

ENV PATH "/composer/vendor/bin:$PATH"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/da290238de6d63faace0343efbdd5aa9354332c5/web/installer \
	&& php -r " \
	    \$signature = '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410'; \
	    \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
	    if (!hash_equals(\$signature, \$hash)) { \
	        unlink('/tmp/installer.php'); \
	        echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
	        exit(1); \
	    }" \
	&& php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer \
	&& rm /tmp/installer.php \
	&& composer --ansi --version --no-interaction

RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com
RUN composer global require phpunit/phpunit
