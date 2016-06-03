#!/bin/bash
GEPID=$1
MYSQL_ROOT_PASSWORD="123456"
MYSQL_USER="gepuser"
MYSQL_PASSWORD="tang3456"
TEMPLATE="../templates"
BASEJFILE="${TEMPLATE}/base_task_definition.json"
CONTBASE=$(cat ${BASEJFILE})
TMP="/tmp"
export GEPID MYSQL_ROOT_PASSWORD MYSQL_USER MYSQL_PASSWORD
echo "Creating Task Definition file for project $1"
sleep 2
cat << EOF > $TMP/$1.json
${CONTBASE}
EOF
cat $TMP/$1.json | jq
