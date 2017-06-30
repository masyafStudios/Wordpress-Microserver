FROM ubuntu:17.04

RUN apt-get update

# basic packages
RUN apt-get install -y gnupg net-tools wget nano less cron ntp

# php
RUN apt-get install -y php php-fpm php-mysql php-gd php-curl php-xdebug
RUN mkdir /run/php
COPY config/fpm.sh /root/fpm.sh
RUN echo "php_admin_flag[log_errors] = on" >> /etc/php/7.0/fpm/pool.d/www.conf
RUN echo "catch_workers_output = yes" >> /etc/php/7.0/fpm/pool.d/www.conf
RUN echo "php_admin_value[error_log] = /media/persistent/log/fpm.err.log" >> /etc/php/7.0/fpm/pool.d/www.conf
RUN echo "clear_env = no" >> /etc/php/7.0/fpm/pool.d/www.conf

# mysql install
RUN apt-get install -y apt-utils \
    && { \
        echo debconf debconf/frontend select Noninteractive;\
        echo mysql-community-server mysql-community-server/data-dir \
            select ''; \
        echo mysql-community-server mysql-community-server/root-pass \
            password 'root'; \
        echo mysql-community-server mysql-community-server/re-root-pass \
            password 'root'; \
        echo mysql-community-server mysql-community-server/remove-test-db \
            select true; \
    } | debconf-set-selections \
    && apt-get install -y mysql-server mysql-client

COPY config/mysql.sql /tmp/mysql.sql
COPY config/mysql.sh /root/mysql.sh
COPY config/data.sh /root/data.sh
COPY config/php-cli.ini /etc/php/7.0/cli/php.ini

# supervisor
RUN apt-get install -y supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# nginx
RUN apt-get install -y nginx
COPY config/nginx-site.conf /etc/nginx/sites-available/default
COPY config/nginx.sh /root/nginx.sh

# init
COPY config/init.sh /root/init.sh

# timezone
COPY config/timezone.sh /root/timezone.sh

# clean up
RUN apt-get clean

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord", "--nodaemon", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
