#!/bin/bash
source common.sh
component=frontend
echo "installing nginx ...."
dnf install nginx -y >>$log_file
if [$? -eq 0]; then
  echo Successfully installed
  else
    echo Installation is failed
    fi


echo "nginx installation is completed"
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file
if [$? -eq 0]; then
  echo Successfully copied the expense.conf file
  else
    echo Failed to copy expense.conf file
    fi
echo "remove default html files under usr/share/nginx/html"
rm -rf /usr/share/nginx/html/* >>$log_file

cd /usr/share/nginx/html/
download_warfiles

echo "enable and start nginx"
systemctl enable nginx >>$log_file
systemctl restart nginx >>$log_file
if [$? -eq 0]; then
  echo Successfully started the nginx service
  else
    echo Failed to start the service
    fi

