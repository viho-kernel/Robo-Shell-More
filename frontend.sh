#!/bin/bash

NAME=catalogue
source ./common.sh
ROOT_ACCESS
NGINX_SETUP

rm -rf /usr/share/nginx/html/*  &>> $LOG_FILE
VALIDATE $? "Removing the Default HTML Code"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>> $LOG_FILE
VALIDATE $? "Downloading Frontend Code"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> $LOG_FILE
VALIDATE $? "Unzipping the FrontEnd Code."

cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf &>> $LOG_FILE
VALIDATE $? "Copying Nginx Configuration."

systemctl restart nginx &>> $LOG_FILE
VALIDATE $? "Restarting Nginx service."

