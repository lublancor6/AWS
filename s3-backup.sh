#!/bin/bash
DATE=$(date +%d%m%y)
COMPRESS="tar -cvzf"
LOGDIR="/usr/local/apache2/logs"
BACKUPDIR="/var/backups/logs"
RMWORK="rm -rf"
COPY2S3="aws s3 mv"
SRVNAME="apache"
S3FOLDER="s3://crosslblanco/logs/${SRVNAME}"

echo "Creating and encapsulating logs"
${COMPRESS} ${BACKUPDIR}/${SRVNAME}-${DATE}.tar.gz ${LOGDIR}

echo "Moving files to S3 bucket"
${COPY2S3} ${BACKUPDIR}/* ${S3FOLDER}/${SRVNAME}-${DATE}.tar.gz
