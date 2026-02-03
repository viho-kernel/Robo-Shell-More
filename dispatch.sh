#!/bin/bash

source ./common.sh
ROOT_ACCESS
name=dispatch

dnf install golang -y &>> $LOG_FILE
VALIDATE $? "Installing Go Langugae"

ID_USER

mkdir -P /app 

curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip  &>> $LOG_FILE
VALIDATE $? "Installing Dispatch Code."

cd /app 

rm -rf /app/* &>> $LOG_FILE

VALIDATE $? "Removing Exisitng Code"

unzip /tmp/dispatch.zip &>> $LOG_FILE

VALIDATE $? "Unzipping the Code."

go mod init dispatch &>> $LOG_FILE

VALIDATE $? "Initializing Dispatch Code."

go get  &>> $LOG_FILE

VALIDATE $? "Get the code"

go build &>> $LOG_FILE

VALIDATE $? "Build the code"

DAEMON

TIME_STAMP
