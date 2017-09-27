#!/bin/bash

#----------------------------------------------------------#
# CREATE DATE : 08/31/2017
# AUTHOR Charles (chulgil.lee@ebankcardservice.com)
# PARAM string $your_domain
#----------------------------------------------------------#
current_file="$(readlink -f ${BASH_SOURCE[0]})"
source_path="$(dirname "$current_file")"
source "$source_path/config.sh"

if [ "$1" == "" ]; then
    echo "Domain parameter 1 is empty"
    exit 1
fi

install_path="$(pwd)/$1";

#----------------------------------------------------------#
# FUNCTIONS
#----------------------------------------------------------#
create_dir()
{
  local dir="$1"
  if [[ -z $dir ]]; then
    echo "Directory name not found."
    exit 1
  elif [[ ! -e $dir ]]; then
    mkdir -p $dir
    echo "The directory has been created : $dir"
  elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
    exit 1
  fi
}  # end of create_dir


escape_string()
{
   printf '%s' "$1" | sed -e 's/[][\\^*+.$-]/\\\1/g'
}


#----------------------------------------------------------#
# CREATE DIRECTORY
#----------------------------------------------------------#
echo "Create default directories....... "
create_dir $1
create_dir "./$1/$DOCKER_DEFAULT_DB_DIR"
create_dir "./$1/$DOCKER_DEFAULT_WEB_DIR"
create_dir "./$1/$DOCKER_DEFAULT_PHP_DIR"

echo "Create default Docker configuration files....."
cp -v "$source_path/default.yml" "$install_path/docker-compose.yml" 
cp -v "$source_path/upload.ini" "$install_path/$DOCKER_DEFAULT_PHP_DIR"

db_name=$(echo "$1" | sed "s/[!@#$%^&*().-]//g")"_db"
sed -i "s/DOCKER_DEFAULT_DOMAIN/$1/g;" "$install_path/docker-compose.yml"
sed -i "s/DOCKER_DEFAULT_DB/$db_name/g;" "$install_path/docker-compose.yml"

exit 0
