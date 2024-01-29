#!/bin/bash

# Disable UFW
sudo ufw disable

# Update the OS
sudo apt update
sudo apt upgrade -y

# List of IP addresses
ip_addresses=("10.3.3.153" "10.3.3.154" "10.3.3.155" "10.3.3.158" "10.3.3.159" "10.3.3.160")

# Define the firewalld zone name
firewall_zone="trusted"

# Check if firewalld is installed
if ! command -v firewalld &> /dev/null
then
    echo "Firewalld is not installed. Installing..."
    sudo apt install firewalld -y
else
    echo "Firewalld is already installed."
fi

# Start and enable firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld

echo "UFW has been disabled, the OS is updated, and Firewalld is installed and activated."


# Create and activate the firewalld zone
echo "Adding new zone - firewall zone. Restring the communications only within Elastic Stack VMs."
sudo firewall-cmd --permanent --new-zone=$firewall_zone
sudo firewall-cmd --permanent --zone=$firewall_zone --set-target=ACCEPT
sudo firewall-cmd --reload

# Add allowed IP addresses to the zone
for ip in "${ip_addresses[@]}"
do
    sudo firewall-cmd --permanent --zone=$firewall_zone --add-source=$ip
done

# Reload firewalld to apply changes
sudo firewall-cmd --reload

echo "Firewall configured to allow communication only between the specified IP addresses."
