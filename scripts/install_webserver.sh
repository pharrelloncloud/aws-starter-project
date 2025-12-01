#!/bin/env bash

# Script to install and configure an nginx web server

set -e

sudo apt update
sudo apt install -y nginx
# Start and enable nginx service

# Start Nginx service and enablem it to start on boot
sudo systemctl start nginx
sudo systemctl enable nginx

# Creates aN iNDEX html file
sudo bash -c 'cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Pharrell On Cloud AWS Server</title>
</head>
<body>
    <h1>Welcome to my Server.</h1>
</body>
</html>
EOF'

echo "Nginx web server installed and configured successfully."

# Retart Nginx to apply changes made 
sudo systemctl restart nginx

# Adjust firewall to allow HTTP traffic
sudo ufw allow 'Nginx HTTP'

echo "Firewall adjusted to allow HTTP traffic."

echo "Web server setup completed."
