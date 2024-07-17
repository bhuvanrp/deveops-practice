#!/bin/bash
source common.sh
component=backend
echo "disable default nodejs"
dnf module disable nodejs -y >>log_file
dnf module enable nodejs:18 -y >>log_file
echo "install nodejs 18"
dnf install nodejs -y >>log_file
useradd expense >>log_file
cp backend.service /etc/systemd/system/backend.service >>log_file
download_warfiles
mkdir /app
cd /app

echo "install all dependence"
npm install >>log_file
echo "load daemon"
systemctl daemon-reload >>log_file
systemctl enable backend >>log_file
echo "start backend"
systemctl start backend >>log_file

dnf install mysql -y

mysql -h mysql.ravitechtest.online -uroot -pExpenseApp@1 < /app/schema/backend.sql