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



TIME_STAMP(){
    END_TIME=$(date +%s)
    echo "Script ended executing at: $(date '+%Y-%m-%d %H:%M:%S') " | tee -a $LOG_FILE
    TOTAL_TIME=$((END_TIME - START_TIME))
    local TOTAL_MINUTES=$((TOTAL_TIME / 60))
    local REMAIN_SECONDS=$((TOTAL_TIME % 60))
    echo -e "$C Total execution time: (${TOTAL_MINUTES} minutes ${REMAIN_SECONDS} sec) $N" | tee -a $LOG_FILE
}