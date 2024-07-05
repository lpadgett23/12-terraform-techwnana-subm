#!/bin/bash
sudo yum update -y && sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

# install docker-compose
sudo DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
sudo mkdir -p $DOCKER_CONFIG/cli-plugins
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.28.1/docker-compose-linux-x86_64" -o $DOCKER_CONFIG/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose