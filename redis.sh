#!/bin/bash

source ./common.sh


dnf module disable redis -y &>> $LOG_FILE
VALIDATE $? "Disabling default redis"

dnf module enable redis:7 -y &>> $LOG_FILE
VALIDATE $? "Enabling Redis Version 7"

dnf install redis -y &>> $LOG_FILE
VALIDATE $? "Installing Redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/c\/protected-mode no' /etc/redis/redis.conf
VALIDATE $? "Enabling Default access"

systemctl enable redis &>> $LOG_FILE
VALIDATE $? "Enabling Redis"

systemctl restart redis &>> $LOG_FILE
VALIDATE $? "Starting Redis Service"

TIME_STAMP