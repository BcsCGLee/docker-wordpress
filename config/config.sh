#!/bin/bash

#----------------------------------------------------------#
# CONSTANTS
#----------------------------------------------------------#
export DOCKER_DEFAULT_DB_PW="Bcs12345"
export DOCKER_DEFAULT_DB_DIR="mariadb"
export DOCKER_DEFAULT_PHP_DIR="nginx/php_conf"
export DOCKER_DEFAULT_WEB_DIR="html"
export DOCKER_DEFAULT_DB_VOLUMES="./$DOCKER_DEFAULT_DB_DIR:/var/lib/mysql:rw"
export DOCKER_DEFAULT_WEB_VOLUMES="./$DOCKER_DEFAULT_WEB_DIR:/var/www/html:rw"

