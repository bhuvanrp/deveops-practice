#!/bin/bash
source common.sh
component=frontend
echo "installing nginx ...."
dnf install nginx -y >>$log_file
echo "nginx installation is completed"
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file
echo "remove default html files under usr/share/nginx/html"
rm -rf /usr/share/nginx/html/* >>$log_file
cd /usr/share/nginx/html/
download_warfiles

echo "enable and start nginx"
systemctl enable nginx >>$log_file
systemctl restart nginx >>$log_file

