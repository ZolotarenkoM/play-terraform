#!/bin/bash
yum -y update
yum -y install httpd
public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
echo "<h2>Public IP: ${public_ip}<h2><br>Build by terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
