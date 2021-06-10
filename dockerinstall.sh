#!/bin/bash

apt-get remove docker docker-engine docker.io containerd runc
apt-get update -y

apt-get install \
apt-transport-https \
ca-certificates \
curl \
software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io -y

usermod -aG docker $USER

systemctl enable docker.service
systemctl enable containerd.service
