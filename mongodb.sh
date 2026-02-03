#!/bin/bash

source ./common.sh
ROOT_ACCESS

dnf install mongodb-org -y &>> $LOG_FILE
VALIDATE $? "Installing MongoDB Server"

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOG_FILE
VALIDATE $? "Copying Mongo files"

systemctl enable mongod &>> $LOG_FILE
VALIDATE $? "Enabling MongoDB Server"
systemctl start mongod &>> $LOG_FILE
VALIDATE $? "Enabling MongoDB Server"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

TIME_STAMP