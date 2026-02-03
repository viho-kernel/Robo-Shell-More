#!/bin/bash

source ./common.sh


dnf install mysql-server -y &>> $LOG_FILE
VALIDATE $? "Installing Mysql server"

systemctl enable mysqld &>> $LOG_FILE
VALIDATE $? "Installing enabling server"

systemctl start mysqld $>> $LOG_FILE
VALIDATE $? "Starting MySQL Server"

mysql_secure_installation --set-root-pass RoboShop@1