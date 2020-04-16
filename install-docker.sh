#!/bin/sh
sudo su
apt update
apt install -y docker.io
service docker start
usermod -aG docker ubuntu
