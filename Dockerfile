FROM alpine:3.19

ENV VERSION 0.10.1

RUN apk update && apk add nginx
RUN mkdir -p /run/nginx

RUN wget -O baikal.zip  https://github.com/sabre-io/Baikal/releases/download/${VERSION}/baikal-${VERSION}.zip
RUN unzip baikal.zip -d /var/www && rm -f baikal.zip

RUN chown -R nobody:nobody /var/www/baikal/Specific
RUN chown -R nobody:nobody /var/www/baikal/config

RUN apk add \
    php82 \
    php82-fpm \
    php82-session \
    php82-openssl \
    php82-pdo \
    php82-pdo_sqlite \
    php82-mysqli \
    php82-pdo_mysql \
    php82-ctype \
    php82-dom \
    php82-mbstring \
    php82-xmlwriter \
    php82-xmlreader

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
