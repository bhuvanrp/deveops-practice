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
  echo -e "\e[31m successfullu installed nodejs \e[0m"
  else
    echo Failed to instal nodejs
    fi
echo add expense user
useradd expense >>log_file
if [ $? -eq 0 ]; then
  echo Successfully added the expense user
  else
    echo Failed to add the expense user
    fi
cp backend.service /etc/systemd/system/backend.service >>log_file
sudo rm -rf /app
mkdir /app
cd /app
download_warfiles
echo "install all dependence"
npm install >>log_file
if [ $? -eq 0 ]; then
  echo success fully install all dependence
echo "load daemon"
fi
echo load daemon reload
systemctl daemon-reload >>log_file
systemctl enable backend >>log_file
echo "start backend"
echo "Installing mysql please waight ...."
dnf install mysql -y
if [ $? -eq 0 ]; then
  echo Successfully installed mysql
  else
    echo failed to install mysql
    fi
systemctl restart backend >>log_file
mysql -h mysql.ravitechtest.online -uroot -pExpenseApp@1 < /app/schema/backend.sql