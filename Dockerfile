FROM alpine:3.10

# Install required packages

RUN apk update && \
    apk add apache2-ssl && \
    apk add php7-apache2 php7-gd php7-pdo_mysql php7-json php7-xml php7-mbstring php7-session php7-curl php7-simplexml php7-ctype php7-dom php7-iconv && \
    apk add php7-pecl-xdebug && \
    apk add wait4ports && \
    apk add mariadb-client && \
    apk add curl

# Remap apache to port 8443

RUN sed -i -re "s/443/8443/gi" /etc/apache2/conf.d/ssl.conf 

# Enable elgg htaccess modifications 

RUN sed -i -re "s/AllowOverride None/AllowOverride All/gi" /etc/apache2/httpd.conf

# Enable rewrite module

RUN sed -i -re "s/^#LoadModule rewrite_module(.*)/LoadModule rewrite_module\1/gi" /etc/apache2/httpd.conf

# Enable xdebug

COPY xdebug.ini /etc/php7/conf.d/xdebug.ini

# Install entrypoint script

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80 8443

ENTRYPOINT [ "/docker-entrypoint.sh" ]