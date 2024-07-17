#!/bin/bash
source common.sh
component=backend
echo "disable default nodejs"
dnf module disable nodejs -y >>log_file
if [ $? -eq 0 ]; then
  echo success fully disabled
  else
    echo Failed to disable
    fi
dnf module enable nodejs:18 -y >>log_file
echo "install nodejs 18"
dnf install nodejs -y >>log_file
if [ $? -eq 0 ]; then
  echo successfullu installed nodejs
  else
    echo Failed to instal nodejs
    fi
useradd expense >>log_file
cp backend.service /etc/systemd/system/backend.service >>log_file
rm -rf /app
mkdir /app
cd /app
download_warfiles
echo "install all dependence"
npm install >>log_file
if [ $? -eq 0 ]; then
  echo success fully install all dependence
echo "load daemon"
fi
systemctl daemon-reload >>log_file
systemctl enable backend >>log_file
echo "start backend"
systemctl start backend >>log_file

dnf install mysql -y
if [ $? -eq 0 ]; then
  ehco Successfully installed mysql
  else
    echo failed to install mysql
    fi

mysql -h mysql.ravitechtest.online -uroot -pExpenseApp@1 < /app/schema/backend.sql