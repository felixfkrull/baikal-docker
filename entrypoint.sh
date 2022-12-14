#!/bin/sh

# do not allow unauthenticated access to prevent errors in relation with the carddav roundcube plugin that uses cURL internally
# see this issue: https://github.com/blind-coder/rcmcarddav/issues/188
sed -i 's/public \$allowUnauthenticatedAccess = true;/public \$allowUnauthenticatedAccess = false;/' /var/www/baikal/vendor/sabre/dav/lib/DAVACL/Plugin.php
sed -i 's/memory_limit = 128M/memory_limit = 256M/' /etc/php7/php.ini

php-fpm8
exec nginx
