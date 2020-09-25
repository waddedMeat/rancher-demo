#! /bin/bash
set -eux

# https://docs.docker.com/engine/install/centos/
yum install -y yum-utils

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce docker-ce-cli containerd.io

# add vagrant user to docker group for easy management
usermod -aG docker vagrant

systemctl enable docker --now
