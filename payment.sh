#!/bin/bash

source ./common.sh
ROOT_ACCESS

dnf install python3 gcc python3-devel -y &>> $LOG_FILE
VALIDATE $? "Installed Python3"

USER_ID

mkdir -p /app 
VALIDATE $? "Created APP DIRECTORY"

curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip  &>> $LOG_FILE
VALIDATE $? "Installing Payment Code"

cd /app 

unzip /tmp/payment.zip &>> $LOG_FILE
VALIDATE $? "Unzipping Payment File"

pip3 install -r requirements.txt &>> $LOG_FILE
VALIDATE $? "Installing Dependencies"

cp $SCRIPT_DIR/payment.service /etc/systemd/system/payment.service &>> $LOG_FILE
VALIDATE $? "Copying service file"

systemctl daemon-reload
systemctl enable payment &>> $LOG_FILE
VALIDATE $? "Enabled Payment."
systemctl start payment &>> $LOG_FILE
VALIDATE $? "Payment success."

TIME_STAMP