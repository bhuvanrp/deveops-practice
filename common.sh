#!/bin/bash
log_file=/tmp/expence.log

download_warfiles(){
echo "download $component code"
curl -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip >> $log_file
echo "Extract code"
cd /usr/share/nginx/html >>log_file
unzip /tmp/$component.zip >>log_file
}