#!/bin/bash

source ./common.sh
ROOT_ACCESS

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>> $LOG_FILE
VALIDATE $? "Copying RabbitMq Repo file"

dnf install rabbitmq-server -y &>> $LOG_FILE
VALIDATE $? "Installing RabbitMQ Server"

systemctl enable rabbitmq-server &>> $LOG_FILE
systemctl start rabbitmq-server
VALIDATE $? "Installing RabbitMQ Server"

id roboshop &>> $LOG_FILE

if [ $? -ne 0 ];then
   
   rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
   rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
   VALIDATE $? "created user and give permissions"
fi

TIME_STAMP