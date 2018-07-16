FROM php:7.1-fpm-alpine

ENV APK_REPO_ORIGIN dl-cdn.alpinelinux.org
ENV APK_REPO_CN mirrors.ustc.edu.cn
ENV PHP_EXT gd mcrypt pdo_mysql pcntl zip
ENV PECL_EXT memcached redis xdebug
ENV PECL_DOWNLOAD /tmp/pear/download

# 替换为中国镜像
RUN sed -i "s/$APK_REPO_ORIGIN/$APK_REPO_CN/g" /etc/apk/repositories \
	&& apk update \
	&& apk --no-cache upgrade

# 安装必要依赖
RUN apk add --no-cache \
	unzip \
	freetype-dev \
	libjpeg-turbo-dev \
	libmcrypt-dev \
	libpng-dev \
	libmemcached-dev \
	zlib-dev

# 安装扩展
RUN apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/  --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure pcntl --enable-pcntl \
	&& docker-php-ext-install -j$(nproc) $PHP_EXT \
	&& pecl install $PECL_EXT \
    && docker-php-ext-enable $PECL_EXT \
    && rm -rfv $PECL_DOWNLOAD/* \
	&& apk del .phpize-deps \
	&& docker-php-source delete

# 安装phpunit
RUN wget http://phar.phpunit.cn/phpunit.phar \
    && chmod 755 phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit

EXPOSE 9000 9090
