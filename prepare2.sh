#!/bin/bash
mkdir confs
cd ./confs
git clone git@github.com:IVyacheslavA/Stend.git

#static ip
sed -i 's/IPADDR=192.168.1.201/IPADDR=192.168.1.202/' /root/confs/Stend/ifcfg-enp0s3
rm -f /etc/sysconfig/network-scripts/ifcfg-enp0s3
cp -v /root/confs/Stend/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-enp0s3
ifdown enp0s3; ifup enp0s3
hostnamectl set-hostname mysql-slave
