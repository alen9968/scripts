#!/bin/bash -
#bash -c "`curl -fsSL https://raw.githubusercontent.com/alen9968/ubuntu/install.sh `"

echo "Start to update ubuntu apt source list...."
cp /etc/apt/sources.list /etc/apt/sources.list_backup
cp $PWD/source16.list /etc/apt/sources.list
apt-get update

echo "Start to install docker...."
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common
curl -fsSL https://download.daocloud.io/docker/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
  "deb [arch=$(dpkg --print-architecture)] https://download.daocloud.io/docker/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo apt-get update
sudo apt-get install -y -q docker-ce=*
sudo service docker start
sudo service docker status

echo "Start to install docker-compose...."
curl -L https://get.daocloud.io/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Start to install k8s...."
echo "deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo gpg --keyserver keyserver.ubuntu.com --recv-keys BA07F4FB #对安装包进行签名
sudo gpg --export --armor BA07F4FB | sudo apt-key add -
sudo apt-get update

echo "Start to config the netplan...."
cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml_backup
cp $PWD/netplan.yaml /etc/netplan/50-cloud-init.yaml
netplan generate
netplan apply
ip a




