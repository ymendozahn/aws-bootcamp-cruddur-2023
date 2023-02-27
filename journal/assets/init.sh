#! /bin/bash

# update the OS
sudo yum update -y

# install postgres client
sudo amazon-linux-extras install postgresql13 -y

# install docker engine
sudo yum install docker -y

# add user to group docker to run all commands without sudo
sudo usermod -a G docker $USER
newgrp docker 

# Install docker-compose
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
sudo chmod -v +x /usr/local/bin/docker-compose

# enable docker service at boot time
sudo systemctl enable docker.service

# start docker service
sudo systemctl start docker.service

# verify docker is running
sudo systemctl status docker.service
