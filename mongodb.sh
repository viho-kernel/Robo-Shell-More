#!/bin/bash

source ./common.sh
ROOT_ACCESS

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOG_FILE
VALIDATE $? "Copying Mongo files"

dnf install mongodb-org -y &>> $LOG_FILE
VALIDATE $? "Installing MongoDB Server"

systemctl enable mongod &>> $LOG_FILE
VALIDATE $? "Enabling MongoDB Server"

systemctl start mongod &>> $LOG_FILE
VALIDATE $? "Enabling MongoDB Server"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing remote connections"

systemctl restart mongod
VALIDATE $? "Restarted MongoDB Service"

TIME_STAMP