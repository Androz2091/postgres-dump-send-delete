#!/bin/bash

TIMESTAMP=`date +%F-%H%M`

PG_PATH="/usr/lib/postgresql/12/bin/pg_dump"
PG_DATABASE="postgres" # Name of the database to backup
APP_NAME="manageinvite" # Name of your application

BACKUPS_DIR="/home/androz/backups/$APP_NAME" # Backups directory
BACKUP_NAME="$APP_NAME-$TIMESTAMP"

REMOTE_HOST_USERNAME="androz" # User used for scp
REMOTE_HOST_ADDRESS="XXX.XXX.XXX.X" # The IP address of the remote server
REMOTE_HOST_PATH="/home/androz/backups" # The path where the backups need to be stored on the remote server

# Make the backups directory if it doesn't exist
mkdir -p $BACKUPS_DIR

# Dump the Postgres database
$PG_PATH -F p -f $BACKUPS_DIR/$BACKUP_NAME.sql -U postgres $PG_DATABASE

# Make a tar file of the dump
tar -zcvf $BACKUPS_DIR/$BACKUP_NAME.tar.gz $BACKUPS_DIR/$BACKUP_NAME.sql

# Synchronize the backups folder with the remote server (send the missing file)
rsync -avz --exclude='*.sql' --delete -e ssh $BACKUPS_DIR $REMOTE_HOST_USERNAME@$REMOTE_HOST_ADDRESS:$REMOTE_HOST_PATH

# Then delete the rest of the files
find $BACKUPS_DIR/ ! -name $BACKUP_NAME.sql -type f -exec rm -f {} +
