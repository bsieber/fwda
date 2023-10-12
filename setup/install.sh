#!/bin/bash

# ---- update the system ---- #

sudo apt update
sudo apt upgrade -y



# ---- Docker ----#

# Add Docker's official GPG key:
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

#install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#setup user for Docker management
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker


# ---- install portainer ---- #

#create volume
docker volume create portainer_data

#install and run
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest



# ---- folders ----#

sudo mkdir /opt/containers/fwda/influxdb/data
sudo mkdir /opt/containers/fwda/grafana/data
sudo mkdir /opt/containers/fwda/r-projects

sudo chmod 777 /opt/containers/fwda/grafana/data
