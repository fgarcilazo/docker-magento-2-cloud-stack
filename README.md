# Dynojet Magento Custom Magento 2.2.2 EE Docker Stack

The docker stack is composed of the following containers
- Centos 7 latest
- Nginx alpine
- Redis alpine
- Composer - centos 7
- Php-fpm - centos 7, php 7.1
- Percona MySQL 5.7 Ubuntu with custom config
- Phpmyadmin alpine

## Stack Requires Latest Docker Latest Docker Composer
docker-compose.yml Version 3

## Container nginx

Builds from  the nginx folder.
Mounts the folder magento2 from the project main folder into the container volume /data/magento2/httpdocs
Opens local port 8000

php-fpm
Builds from the php-fpm folder.
Mounts the folder magento2 from the project main folder into the container volume /data/magento2/httpdocs
Opens local port 9000

composer:
Builds from the composer folder.
Mounts the folder magento2 from the project main folder into the container volume /data/magento2/httpdocs
This container will execute composer install inside the folder /data/magento2/httpdocs

To add other program when the docker stack starts add them to the runall.sh

redis:

starts a redis container and opens up port 6379

mysql:

The container will create a folder mysqldata inside the project main folder. All data is persistent.

Please change or set the mysql environment variables
MYSQL_DATABASE: 'xxxx'
MYSQL_ROOT_PASSWORD: 'xxxx'
MYSQL_USER: 'xxxx'
MYSQL_PASSWORD: 'xxxx'
MYSQL_ALLOW_EMPTY_PASSWORD: 'xxxxx'

Opens port 3306

Note, on your host, port 3306 might already be in use. So before running docker-compose.yml, under the docker-compose.yml's mysql section change the host's port number to something other than 3306, select any as long as that port is not already being used locally on your machine.

phpmyadmin:

Creates a fully working phpmyadmin container.
Opens up port 8080

To access phpmyadmin http://localhost:8080 or http://ipofthedockerserver:8080

## Setup

Make sure  you have overlay or overlay2 enable for your storage drive https://docs.docker.com/engine/userguide/storagedriver/overlayfs-driver/

All you need to do is chown 2000.2000 magento2/ -R The user apache with guid 2000 and uid 2000 is set in all containers to
avoid permissions issues.

To start/build the stack.

Use - docker-compose up  or docker-compose up -d to run the container on detached mode. 

Composer will take some time to execute but it will finish once composer is finished you can install magento.

After the build has finished you can ctrl+c and docker-compose start and stop all containers.


## Installing Magento

You will need to download the latest version of Magento Cloud Edition, follow this link: https://github.com/magento/magento-cloud

Make sure you put the install under the Magento2 folder. 

To ensure all file permission are set correctly on the NGINX server, access the server's command line and run the following
commands:

To access your web server's command line, run the following commands on your CLI.

docker exec -it <web-servers-container-name> bash

Once you've gained access, run the following command to change permissions on the folder where magento will be installed.

cd /data/magento2/httpdocs && find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; && find var vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} \; && chown -R :apache . && chmod u+x bin/magento

cd /data/magento2/httpdocs && find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; && find var vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} \; && chown -R :apache . && chmod u+x bin/magento

## Setting up Magento

To access the magento setup wizard, to to the following url: http://localhost:8000 or http://ipofthedockerserver:8000

Proceed with the installation using the magento setup wizard.

## Potential Improvements

To improve the Docker performance when mapping volumes between containers and host, add NFS, Unison or dockersync.

This helps if the website is loading slow on your machine.   
