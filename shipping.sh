#!/bin/bash

source ./common.sh
NAME=shipping
ROOT_ACCESS
JAVA_SETUP
ID_USER
DAEMON


curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip &>> $LOG_FILE
VALIDATE $? "Downloading Shipping Code"

cd /app 

unzip /tmp/shipping.zip
VALIDATE $? "Unzipping the files"

mvn clean package &>> $LOG_FILE
VALIDATE $? "Builing maven file"

mv target/shipping-1.0.jar shipping.jar &>> $LOG_FILE
VALIDATE $? "Moving the Jar files"

MYSQL_SETUP

systemctl restart shipping

TIME_STAMP