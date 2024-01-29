#!/bin/bash

# Update package information
sudo apt update

# Install essential security tools
sudo apt install -y fail2ban aide lynis rkhunter clamav etckeeper openscap-utils sysstat unattended-upgrades

# Enable and start essential security services
sudo systemctl enable --now fail2ban lynis rkhunter clamav etckeeper

# Enable automatic security updates
sudo dpkg-reconfigure -plow unattended-upgrades

# Enable and start firewalld
sudo apt install -y firewalld
sudo systemctl enable --now firewalld

echo "Essential security tools installed and services started."
