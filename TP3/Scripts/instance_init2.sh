#!/usr/bin/env bash

apt -y update && apt -y upgrade

# Install MariaDB 
sudo apt install mariadb-server -y


touch /tmp/cloud-init-ok
