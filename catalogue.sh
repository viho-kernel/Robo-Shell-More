#!/bin/bash

NAME=catalogue
source ./common.sh
ROOT_ACCESS
NODE_JS
ID_USER
APP_SETUP
DAEMON

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOG_FILE
VALIDATE $? "Copying the MongoDB File"

dnf install mongodb-mongosh -y &>> $LOG_FILE

if [ $(mongosh --host $MONGODB_HOST --quiet --eval 'db.getMongo().getDBNames().indexOf("catalogue")' ) -le 0 ]; then
    VALIDATE $? "Loading products"
else
    mongosh --host $MONGODB_HOST </app/db/master-data.js
    echo -e " $(date "+%Y-%m-%d %H:%M:%S") | Products already loaded. "
fi

TIME_STAMP