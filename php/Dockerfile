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

# 安装Composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_ALLOW_XDEBUG 1
ENV COMPOSER_DISABLE_XDEBUG_WARN 1

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php --install-dir=/usr/bin/ --filename=composer \
	&& php -r "unlink('composer-setup.php');" \
	&& composer config -g repo.packagist composer https://packagist.phpcomposer.com

EXPOSE 9000 9090
