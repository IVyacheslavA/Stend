#!/bin/bash
(ping -c 4 8.8.8.8 1>/dev/nul & echo "conection ok") || echo "connection failed"

#mysql install
rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-7.noarch.rpm
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
yum -y --enablerepo=mysql80-community install mysql-community-server 1>/dev/null
systemctl start mysqld
systemctl enable mysqld
systemctl status mysqld | head -n 3
systemctl stop firewalld
systemctl disable firewalld

grep "A temporary password" /var/log/mysqld.log 
mysql -uroot -p
