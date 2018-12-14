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
    git \
	unzip \
	freetype-dev \
	libjpeg-turbo-dev \
	libmcrypt-dev \
	libpng-dev \
	libmemcached-dev \
	zlib-dev

# 安装扩展
RUN apk add --no-cache $PHPIZE_DEPS \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/  --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure pcntl --enable-pcntl \
	&& docker-php-ext-install -j$(nproc) $PHP_EXT \
	&& pecl install $PECL_EXT \
    && docker-php-ext-enable $PECL_EXT \
    && rm -rfv $PECL_DOWNLOAD/* \
	&& docker-php-source delete

# 安装Composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_ALLOW_XDEBUG 1
ENV COMPOSER_DISABLE_XDEBUG_WARN 1

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php --install-dir=/usr/bin/ --filename=composer \
	&& php -r "unlink('composer-setup.php');" \
	&& composer config -g repo.packagist composer https://packagist.phpcomposer.com

RUN git clone https://github.com/tideways/php-xhprof-extension.git \
    && cd php-xhprof-extension \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rfv php-xhprof-extension

EXPOSE 9000 9090
