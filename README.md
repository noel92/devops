# Docker配置开发环境
请根据自己Docker环境配置.env，请参考.env.default

## 开发环境
[nginx](https://hub.docker.com/_/nginx/)(latest)  
[php](https://hub.docker.com/_/php/)(基于fpm)  
[mysql](https://hub.docker.com/_/mysql/)(latest)  
[redis](https://hub.docker.com/_/redis/)(latest)  
[memcached](https://hub.docker.com/_/memcached/)(latest)

## PHP
支持扩展
> Core ctype curl date dom fileinfo filter ftp gd hash iconv json libxml mbstring mcrypt mysqlnd openssl pcntl pcre PDO pdo_mysql pdo_sqlite Phar posix readline Reflection session SimpleXML SPL sqlite3 standard tokenizer xml xmlreader xmlwriter zip zlib memcached redis xdebug

支持composer
>phpunit

## Windows
安装Docker Toolbox，至少为
[v17.04.0-ce](https://github.com/docker/toolbox/releases/tag/v17.04.0-ce)，
虚拟机配置共享文件夹为E:\dev，映射为/home/dev
