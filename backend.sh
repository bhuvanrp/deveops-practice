#!/bin/bash
source common.sh
component=backend
echo "disable default nodejs"
dnf module disable nodejs -y >>log_file
if [ $? -eq 0 ]; then
  echo "\e[32msuccessfully disabled \e[0m"
  else
    echo "\e[31mFailed to disable\e[0m"
    fi
dnf module enable nodejs:18 -y >>log_file
echo "install nodejs 18"
dnf install nodejs -y >>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m successfullu installed nodejs \e[0m"
  else
    echo "\e[31mFailed to instal nodejs\e[0m"
    fi
echo addng user as expense
useradd expense >>log_file
if [ $? -eq 0 ]; then
  echo "\e[32mSuccessfully added the expense user\e[0m"
  else
    echo "\e[31mFailed to add the expense user\e[0m"
    fi
    echo copieng backend.service file to /etc/systemd/system/backend.service path
cp backend.service /etc/systemd/system/backend.service >>log_file
if [ $? -eq 0 ]; then
  echo "\e[32mSuccessfully copied backend service file\e[0m"
  else
    echo "\e[31mFailed to copied\e[0m"
    fi
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