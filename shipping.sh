#!/bin/bash

source ./common.sh
NAME=shipping
ROOT_ACCESS

dnf install maven -y &>> $LOG_FILE
VALIDATE $? "Installing Maven (Java)"

ID_USER

mkdir -p /app $>> $LOG_FILE
VALIDATE $? "Creating /app directory"

cd /app
VALIDATE $? "Moving to /app directory"

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip  &>> $LOG_FILE
VALIDATE $? "Downloading Shipping Artifact"

unzip /tmp/shipping.zip &>> $LOG_FILE
VALIDATE $? "Unzipping the shipping"

mvn clean package &>> $LOG_FILE
VALIDATE $? "Building Shipping Application with Maven"

mv target/shipping-1.0.jar shipping.jar &>> $LOG_FILE
VALIDATE $? "Renaming shipping jar"

cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service &>> $LOG_FILE
VALIDATE $? "Copying Shipping Service file"

systemctl daemon-reload
systemctl enable shipping &>>$LOG_FILE
systemctl start shipping
VALIDATE $? "Starting Shipping Service"

dnf install mysql -y &>> $LOG_FILE
VALIDATE $? "Installing MySQL Client"

mysql -h ${MYSQL_HOST} -uroot -pRoboShop@1 < /app/db/schema.sql
VALIDATE $? "Loading schema.sql into MySQL"

mysql -h ${MYSQL_HOST} -uroot -pRoboShop@1 < /app/db/app-user.sql 
VALIDATE $? "Loading app-user.sql into MySQL"

mysql -h ${MYSQL_HOST} -uroot -pRoboShop@1 < /app/db/master-data.sql
VALIDATE $? "Loading master-data.sql into MySQL"

systemctl restart shipping
VALIDATE $? "Restarting Shipping Service"

TIME_STAMP