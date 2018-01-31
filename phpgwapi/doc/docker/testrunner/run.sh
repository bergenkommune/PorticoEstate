#!/bin/bash

#Wait for postgres container
sleep 5

cd /var/www/html/portico

#Setup web application with header.inc.php for test env.
rm -rf /var/www/html/portico/header.inc.php
ln -s /var/www/html/portico/phpgwapi/doc/docker/testrunner/header.inc.php /var/www/html/portico/header.inc.php

composer install

./vendor/bin/codecept run
#rm -rf /var/www/html/portico/header.inc.php