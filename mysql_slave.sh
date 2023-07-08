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

#gitkeys
ssh-keygen -t ed25519 -C "slave-mysql"
cat ~/.ssh/id_ed25519.pub

#static ip
rm -f /etc/sysconfig/network-scripts/ifcfg-enp0s3
cp -v /root/confs/Stend/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-enp0s3
ifdown enp0s3; ifup enp0s3

exit

#mysql install
rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-7.noarch.rpm
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
yum -y --enablerepo=mysql80-community install mysql-community-server
systemctl start mysqld
systemctl enable mysqld
systemctl status mysqld | head -n 3
systemctl stop firewalld
systemctl disable firewalld

grep "A temporary password" /var/log/mysqld.log 
mysql -uroot -p
ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY 'Testpass1$';
