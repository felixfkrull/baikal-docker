FROM alpine:3.10

ENV VERSION 0.6.0

RUN apk update && apk add nginx
RUN mkdir -p /run/nginx

RUN wget -O baikal.zip  https://github.com/sabre-io/Baikal/releases/download/${VERSION}/baikal-${VERSION}.zip
RUN unzip baikal.zip -d /var/www && rm -f baikal.zip

RUN chown -R nobody:nobody /var/www/baikal/Specific

RUN apk add \
    php7 \
    php7-fpm \
    php7-session \
    php7-openssl \
    php7-pdo \
    php7-pdo_sqlite \
    php7-mysqli \
    php7-pdo_mysql \
    php7-ctype \
    php7-dom \
    php7-mbstring \
    php7-xmlwriter \
    php7-xmlreader \
    php7-json

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
