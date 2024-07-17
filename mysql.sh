#!/bin/bash
source common.sh
echo "Disable default mysql"
dnf module disable mysql -y  >>$log_file
echo "copy mysql.report file to /etc/yum.repos.d/"
cp mysql.repo /etc/yum.repos.d/mysql.repo  >>$log_file
echo "install mysql 5.7 version"
dnf install mysql-community-server -y  >>$log_file
echo "enable and start mysql server"
systemctl enable mysqld
systemctl start mysqld
echo "connecting to mysql"
mysql_secure_installation --set-root-pass ExpenseApp@1 >>$log_file