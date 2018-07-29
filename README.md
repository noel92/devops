# Docker配置开发环境
请根据自己Docker环境配置.env，请参考.env.dist

## 开发环境
[nginx](https://hub.docker.com/_/nginx/)(nginx:1.15-alpine)  
[php](https://hub.docker.com/_/php/)(基于php:7.1-fpm-alpine)  
[mysql](https://hub.docker.com/_/mysql/)(8)  
[redis](https://hub.docker.com/_/redis/)(redis:4-alpine)  
[memcached](https://hub.docker.com/_/memcached/)(memcached:1.5-alpine)

## PHP
支持模块
> Core ctype curl date dom fileinfo filter ftp gd hash iconv json libxml mbstring
mcrypt memcached mysqlnd openssl pcntl pcre PDO pdo_mysql pdo_sqlite Phar posix
readline redis Reflection session SimpleXML SPL sqlite3 standard tokenizer xdebug
xml xmlreader xmlwriter zip zlib

支持Composer

## Windows
安装Docker Toolbox，至少为
[v17.04.0-ce](https://github.com/docker/toolbox/releases/tag/v17.04.0-ce)，
虚拟机配置共享文件夹为E:\dev，映射为/home/dev
