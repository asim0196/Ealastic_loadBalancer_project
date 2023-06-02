#!/bin/bash
sudo yum install httpd -y
systemctl start httpd 
systemctl enable httpd
echo "hello private ip is $HOSTNAME " > /var/www/html/index.html