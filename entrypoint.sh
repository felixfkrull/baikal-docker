#!/bin/sh

# do not allow unauthenticated access to prevent errors in relation with the carddac roundcube plugin that uses cURL internally
# see this issue: https://github.com/blind-coder/rcmcarddav/issues/188
sed -i 's/public \$allowUnauthenticatedAccess = true;/public \$allowUnauthenticatedAccess = false;/' /var/www/baikal/vendor/sabre/dav/lib/DAVACL/Plugin.php

php-fpm7
exec nginx
