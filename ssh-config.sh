#!/bin/bash

# Variables
sshd_config="/etc/ssh/sshd_config"
backup_file="/etc/ssh/sshd_config.bak"

# Backup the original sshd_config file
sudo cp $sshd_config $backup_file

# Disable root login and password authentication, and enable pubkey authentication
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' $sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' $sshd_config
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' $sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' $sshd_config
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' $sshd_config

# Restart SSH service
sudo service ssh restart

echo "SSH configuration updated. Root login and password authentication disabled. Only pubkey authentication allowed."
