#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h1> this is my home page "$HOSTNAME" </h1>" > /var/www/html/index.html 