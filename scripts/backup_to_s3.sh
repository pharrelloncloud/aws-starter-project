#!/bin/env bash
# Script to back up a directory to an S3 bucket

WEB_DIR="/var/www/html"

BUCKET_NAME="aws-backup-bucket"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

BACKUP_FILE="/tmp/site_backup_$TIMESTAMP.tar.gz"

# Create a tar.gz archive of the web directory
echo "Creating backup of $WEB_DIR..."

tar -czf $BACKUP_FILE $WEB_DIR

#Loading that backuo to S3
echo "Uploading backup to S3 bucket $BUCKET_NAME..."
aws s3 cp $BACKUP_FILE s3://$BUCKET_NAME/backups/

# Checks to see if the upload was successful
if [ $? -eq 0 ]; then
    echo "Backup uploaded successfully to s3://$BUCKET_NAME/backups/"
    # Removes the local backup file to save space
    rm $BACKUP_FILE
    echo "Local backup file removed."
else
    echo "Failed to upload backup to S3."
fi

echo "Backup process completed."