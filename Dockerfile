FROM alpine:3.10

ENV VERSION 0.6.0

RUN apk update \
    && apk add nginx \
    php7 \
    php7-fpm \
    php7-session \
    php7-openssl \
    php7-pdo \
    php7-pdo_sqlite \
    php7-mysqli \
    php7-pdo_mysql \
    php7-ctype

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /run/nginx

RUN wget -O baikall.zip  https://github.com/sabre-io/Baikal/releases/download/${VERSION}/baikal-${VERSION}.zip
RUN unzip baikall.zip -d /var/www && rm -f baikall.zip

RUN chown -R nobody:nobody /var/www/baikal/Specific

EXPOSE 80
