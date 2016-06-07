#!/bin/bash
GEPID=$1
MYSQL_ROOT_PASSWORD="123456"
MYSQL_USER="gepuser"
MYSQL_PASSWORD="tang3456"
TEMPLATE="../templates"
BASEJFILE="${TEMPLATE}/base_task_definition.json"
CONTBASE=$(cat ${BASEJFILE})
TMP="/tmp"

# Creating task difinition parameters

cat << EOF > $TMP/${GEPID}.json
{
    "family": "task-${GEPID}", 
    "containerDefinitions": [
        {
            "name": "mysql-${GEPID}", 
            "image": "912965902418.dkr.ecr.us-east-1.amazonaws.com/geppetto-mysql:latest",
            "cpu": 0, 
            "memory": 256, 
            "portMappings": [
                {
                    "containerPort": 3306
                }
            ], 
            "essential": true, 
            "entryPoint": [
                ""
            ], 
            "command": [
                ""
            ], 
            "environment": [
                {
                    "name": "MYSQL_ROOT_PASSWORD", 
                    "value": "${MYSQL_ROOT_PASSWORD}"
                },
                {
                    "name": "MYSQL_USER", 
                    "value": "${MYSQL_USER}"
                },
                {
                    "name": "MYSQL_PASSWORD", 
                    "value": "${MYSQL_PASSWORD}"
                }
            ], 
            "mountPoints": [
                {
                    "sourceVolume": "MysqlFolder", 
                    "containerPath": "/docker-entrypoint-initdb.d", 
                    "readOnly": false
                }
            ], 
            "hostname": "mysql", 
            "readonlyRootFilesystem": false
        },
        {
            "name": "tomcat-${GEPID}", 
            "image": "912965902418.dkr.ecr.us-east-1.amazonaws.com/geppetto-tomcat:latest", 
            "cpu": 0, 
            "memory": 256, 
            "links": [
                "mysql-${GEPID}:mydb"
            ], 
            "portMappings": [
                {
                    "containerPort": 8080
                }
            ], 
            "mountPoints": [
                {
                    "sourceVolume": "TomcatFolder", 
                    "containerPath": "/docker-entrypoint-initapp.d", 
                    "readOnly": false
                }
            ], 
            "hostname": "tomcat", 
            "readonlyRootFilesystem": false
        },
        {
            "name": "nodejs-${GEPID}", 
            "image": "912965902418.dkr.ecr.us-east-1.amazonaws.com/geppetto-node:latest", 
            "cpu": 0, 
            "memory": 256, 
            "links": [
                "mysql-${GEPID}:mydb"
            ], 
            "portMappings": [
                {
                    "containerPort": 9090
                }
            ], 
            "mountPoints": [
                {
                    "sourceVolume": "NodeFolder", 
                    "containerPath": "/docker-entrypoint-initapi.d", 
                    "readOnly": false
                }
            ], 
            "hostname": "nodejs", 
            "readonlyRootFilesystem": false
        }
    ],
"volumes": [
        {
            "name": "MysqlFolder", 
            "host": {
                "sourcePath": "/home/shared/${GEPID}/mysql"
            }
        },
        {
            "name": "TomcatFolder", 
            "host": {
                "sourcePath": "/home/shared/${GEPID}/tomcat"
            }
        },
        {
            "name": "NodeFolder", 
            "host": {
                "sourcePath": "/home/shared/${GEPID}/nodejs"
            }
        }
    ]


}
EOF
cat $TMP/${GEPID}.json | jq .

# Deployment of the task definition in ECS

if [ $(whoami) = root ];
then
	aws ecs register-task-definition --cli-input-json file:///tmp/${GEPID}.json
else
	sudo aws ecs register-task-definition --cli-input-json file:///tmp/${GEPID}.json

fi
