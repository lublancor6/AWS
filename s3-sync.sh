#!/bin/bash
#Send logs to S3 
LOGDIR=
S3BUCKET=
DATE=$(date +%d%m%y)
HOST=$(hostname)
SYNC="s3cmd sync"

echo "Sincronyzing logs to S3 Bucket"
${SYNC} ${LOGDIR} ${S3BUCKET}
