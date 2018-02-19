#!/bin/sh

#sleep for 4 seconds  and wait for mysql to start
sleep 4

su - apache -s/bin/bash -c "cd /data/magento2/httpdocs && composer install"
