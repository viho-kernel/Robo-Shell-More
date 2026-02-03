#!/bin/bash

source ./common.sh


dnf install mysql-server -y &>> $LOG_FILE
VALIDATE $? "Installing Mysql server"

systemctl enable mysqld &>> $LOG_FILE
VALIDATE $? "Installing Mysql server"

systemctl start mysqld

mysql_secure_installation --set-root-pass RoboShop@1