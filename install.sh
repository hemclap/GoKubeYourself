#!/bin/sh

CMD=${1:-install}
PREFIX=${2:-/usr/local/bin}

echo "Attempting to install minikube and assorted tools to $PREFIX"

if ! command kubectl >/dev/null 2>&1; then
  version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
  echo "Installing kubectl version $version"
  curl -LO "https://storage.googleapis.com/kubernetes-release/release/$version/bin/linux/amd64/kubectl"
  chmod +x kubectl
  mv kubectl "$PREFIX"
else
  echo "kubetcl is already installed"
fi

if ! command minikube >/dev/null 2>&1; then
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube
  mv minikube "$PREFIX"
  echo "Configuring minikube..."
  minikube config set ShowBootstrapperDeprecationNotification false
  minikube config set WantUpdateNotification false
  minikube config set WantReportErrorPrompt false
  minikube config set WantKubectlDownloadMsg false
  minikube config set driver docker
else
  echo "minikube is already installed"
fi

echo "Starting minikube..."
sudo /usr/local/bin/minikube --vm-driver=docker --bootstrapper=localkube start
set tempFolder=$PWD

cd ~

#rm .kube -rf
#rm .minikube -rf

#sudo mv /root/.kube $HOME/
#sudo chown -R $USER $HOME/.kube
#sudo chgrp -R $USER $HOME/.kube

#sudo mv /root/.minikube $HOME/
#sudo chown -R $USER $HOME/.minikube

#cd $tempFolder

sed -i "s:/root/:/home/$USER/:g" $HOME/.kube/config

echo "Your cluster is ready"
