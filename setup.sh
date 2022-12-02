#!/bin/bash

## This script configures a raspberry pi with a Z-Wave.Me RaZberry 7 Pro controller

# This ensures the script runs with sudo.
 
if (($EUID != 0)); then
  if [[ -t 1 ]]; then
    sudo "$0" "$@"
  else
    exec 1>output_file
    gksu "$0 $@"
  fi
  exit
fi

## Update System
apt-get update && apt-get upgrade -y


# It's assumed here we're running this on 
# a clean install of Raspbian

## Required on Raspbian
systemctl disable hciuart
## Install Docker
apt-get install docker.io -y
## Allow pi to launch docker containers
usermod -aG docker pi

## Make directory for docker apps
mkdir /usr/local/bin/docker
## Make config directory for home-assistant 
mkdir /usr/local/bin/docker/home-assistant
## Make config directory for nginx
mkdir /usr/local/bin/docker/nginx

cp ./home-assistant-configs/docker.homeassistant.service /etc/systemd/system/docker.homeassistant.service
cp ./nginx-configs/docker.nginx.service /etc/systemd/system/docker.nginx.service

systemctl reload docker.homeassistant.service 
systemctl reload docker.nginx.service 


systemctl enable docker.homeassistant
systemctl enable docker.nginx

systemctl start docker.homeassistant
systemctl start docker.nginx