#!/bin/bash
hostnamectl set-hostname mysql-slave
#Checking connection
(ping -c 4 8.8.8.8 1>/dev/nul & echo "conection ok") || echo "connection failed"
#update
yum update -y 1>/dev/null
read -t 1 -p "0"

# install vim
yum install vim -y 1>/dev/null & echo "vim ok"
read -t 1 -p "1"
yum install git -y 1>/dev/null & echo "git ok"
read -t 1 -p "2"
yum install wget -y 1>/dev/null & echo "wget ok"
