#!/bin/bash
#Send logs to S3 
LOGDIR="/usr/local/apache2/logs"
DATE=$(date +%d%m%y)
HOST=$(hostname)
S3BUCKET="s3://crosslblanco/logs/${HOST}/"
SYNC="aws s3 sync"

echo "Sincronyzing logs to S3 Bucket"
${SYNC} ${LOGDIR} ${S3BUCKET}
