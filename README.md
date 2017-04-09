# Docker配置开发环境
请根据自己Docker环境配置.env，请参考.env.default

## 开发环境
[nginx](https://hub.docker.com/_/nginx/)(latest)  
[php](https://hub.docker.com/_/php/)(基于fpm，配置composer)  
[mysql](https://hub.docker.com/_/mysql/)(latest)

## PHP
支持扩展
> Core ctype curl date dom fileinfo filter ftp gd hash iconv json libxml mbstring mcrypt mysqlnd openssl pcntl pcre PDO pdo_mysql pdo_sqlite Phar posix readline Reflection session SimpleXML SPL sqlite3 standard tokenizer xml xmlreader xmlwriter zlib

## Windows
安装Docker Toolbox，虚拟机配置共享文件夹为E:\dev，映射为/home/dev
