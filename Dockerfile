FROM alpine:3.16

ENV VERSION 0.9.4

RUN apk update && apk add nginx
RUN mkdir -p /run/nginx

RUN wget -O baikal.zip  https://github.com/sabre-io/Baikal/releases/download/${VERSION}/baikal-${VERSION}.zip
RUN unzip baikal.zip -d /var/www && rm -f baikal.zip

RUN chown -R nobody:nobody /var/www/baikal/Specific
RUN chown -R nobody:nobody /var/www/baikal/config

RUN apk add \
    php8 \
    php8-fpm \
    php8-session \
    php8-openssl \
    php8-pdo \
    php8-pdo_sqlite \
    php8-mysqli \
    php8-pdo_mysql \
    php8-ctype \
    php8-dom \
    php8-mbstring \
    php8-xmlwriter \
    php8-xmlreader

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
