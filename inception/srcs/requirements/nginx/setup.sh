#!/bin/bash
cd /var/www/html
touch index.php
ls -b | grep -v index.php | xargs --no-run-if-empty -Iname mv name index.php
