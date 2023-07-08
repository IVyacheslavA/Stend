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
exit
#gitkeys
ssh-keygen -t ed25519 -C "slave-mysql"
cat ~/.ssh/id_ed25519.pub
exit
mkdir confs
cd ./confs
git clone git@github.com:IVyacheslavA/Stend.git
#static ip
sed -i 's/IPADDR=192.168.1.201/IPADDR=192.168.1.202/' /root/confs/Stend/ifcfg-enp0s3
rm -f /etc/sysconfig/network-scripts/ifcfg-enp0s3
cp -v /root/confs/Stend/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-enp0s3
ifdown enp0s3; ifup enp0s3



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
exit
ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY 'Testpass1$';
