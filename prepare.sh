#!/bin/bash
hostnamectl set-hostname mysql-slave
#Checking connection
(ping -c 4 8.8.8.8 1>/dev/nul & echo "conection ok") || echo "connection failed"
#update
yum update -y 1>/dev/null

# install vim
yum install vim -y 1>/dev/null & echo "vim ok"
yum install git -y 1>/dev/null & echo "git ok"
yum install wget -y 1>/dev/null & echo "wget ok"
