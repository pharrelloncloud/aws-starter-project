#!/bin/env bash
# Script to back up a directory to an S3 bucket

WEB_DIR="/var/www/html"
BUCKET_NAME="pharrelloncloud-backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="/tmp/site_backup_$TIMESTAMP.tar.gz"

echo "Creating backup of $WEB_DIR..."
tar -czf $BACKUP_FILE $WEB_DIR

echo "Uploading backup to S3 bucket $BUCKET_NAME..."
aws s3 cp $BACKUP_FILE s3://$BUCKET_NAME/web-backups/

if [ $? -eq 0 ]; then
    echo "Backup uploaded successfully to s3://$BUCKET_NAME/web-backups/"
    rm $BACKUP_FILE
    echo "Local backup file removed."
else
    echo "Failed to upload backup to S3."
fi

echo "Backup process completed."
