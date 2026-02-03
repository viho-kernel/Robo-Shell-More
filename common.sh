#!/bin/bash

START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
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

END_TIME=$(date '+%Y-%m-%d %H:%M:%S')

TIME_STAMP(){
    local start_time=$(date -d "$START_TIME" +%s)
    local end_time=$(date -d "$END_TIME" +%s)
    local TOTAL_SECONDS=$((end_time - start_time))
    local TOTAL_MINUTES=$((TOTAL_SECONDS / 60))
    echo -e "$C Total execution time: ${total_seconds} seconds (${total_minutes} minutes) $N" | tee -a $LOG_FILE
}