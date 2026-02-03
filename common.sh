#!/bin/bash

USER_ID=$(id -u)
LOG_FOLDER="/var/log/Shell-Roboshop-logs"
LOG_FILE="$LOG_FOLDER/$0.log"
SCRIPT_DIR=$(pwd)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
P="\e[35m"
C="\e[36m"
N="\e[0m"
START_TIME=$(date +%s)
MONGODB_HOST=mongodb.opsora.space

echo "Script started executing at: $(date '+%Y-%m-%d %H:%M:%S') " | tee -a $LOG_FILE

ROOT_ACCESS() {
if [ $USER_ID -ne 0 ]; then
echo -e "$R Please run this script with root user access $N" | tee -a $LOG_FILE
exit 1
fi
}

mkdir -p $LOG_FOLDER

VALIDATE() {
    if [ $1 -ne 0 ]; then
       echo -e " $R $2... Failed $N " | tee -a $LOG_FILE
    else
       echo -e " $G $2.... Success $N " | tee -a $LOG_FILE
    fi
}

NODE_JS(){
dnf module disable nodejs -y &>> $LOG_FILE
VALIDATE $? "Disabling NodeJS"

dnf module enable nodejs:20 -y &>> $LOG_FILE
VALIDATE $? "Enabling NodeJS"

dnf install nodejs -y &>> $LOG_FILE
VALIDATE $? "Installing NodeJS"
}

ID_USER(){
id roboshop &>> $LOG_FILE
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
    VALIDATE $? "Creating User"
else
   echo -e "Roboshop user already exist ... $Y Skipping $N"
fi
}

APP_SETUP(){
    mkdir -p /app &>> $LOG_FILE
    VALIDATE $? "Creating APP Directory!"

    curl -o /tmp/$NAME.zip https://roboshop-artifacts.s3.amazonaws.com/$NAME-v3.zip &>> $LOG_FILE
    VALIDATE $? "Downloading Application Code"
    cd /app 
    VALIDATE $? "Moving to app Directory"
    rm -rf /app* &>> $LOG_FILE
    VALIDATE $? "Removing Exisiting Code"
    unzip /tmp/$NAME.zip
    VALIDATE $? "Unzipping the Code"
    npm install
    VALIDATE $? "Installing Dependencies"
}

DAEMON(){
    cp $SCRIPT_DIR/$NAME.service /etc/systemd/system/$NAME.service &>> $LOG_FILE
VALIDATE $? "Copying the service file"

    systemctl daemon-reload &>> $LOG_FILE
    VALIDATE $? "Reload the Daemon"
    systemctl enable $NAME  &>> $LOG_FILE
    VALIDATE $? "Enable $NAME Service"
    systemctl start $NAME &>> $LOG_FILE
    VALIDATE $? "Start $NAME Seervice"
}
TIME_STAMP(){
    END_TIME=$(date +%s)
    echo "Script ended executing at: $(date '+%Y-%m-%d %H:%M:%S') " | tee -a $LOG_FILE
    TOTAL_TIME=$((END_TIME - START_TIME))
    local TOTAL_MINUTES=$((TOTAL_TIME / 60))
    local REMAIN_SECONDS=$((TOTAL_TIME % 60))
    echo -e "$C Total execution time: (${TOTAL_MINUTES} minutes ${REMAIN_SECONDS} sec) $N" | tee -a $LOG_FILE
}