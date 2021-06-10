#!/bin/bash

#Installation
apt-get install -y wget

#Intallation Minikube or check if is already installede
if minikube start; then
	echo Minikube is already installed returned true
else
	echo Download Minikube...
	wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x minikube-linux-amd64
	mv minikube-linux-amd64 /usr/local/bin/minikube
fi

#Installation Kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt update
apt install -y kubectl

#Installation Helm or check if is already installed
if helm version; then
	echo helm is already installed returned true
else
	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
	chmod 700 get_helm.sh
	./get_helm.sh
fi

#Installation prometheus
helm repo add stable https://charts.helm.sh/stable
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo update  
helm install stable/prometheus-operator --generate-name --namespace monitor
