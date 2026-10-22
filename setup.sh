#!/bin/bash

set -e

PAGE_TITLE="${1:-My Automated Server}"

echo "Updating package list,,,"
sudo apt update

if command -v nginx > /dev/null; then
 echo "nginx already installed, skipping ..."
else
 echo "Installing nginx..."
 sudo apt install -y nginx
fi

sudo tee /var/www/html/index.html > /dev/null <<EOF
<!DOCTYPE html> 
<html>
 <head><title>$PAGE_TITLE</title></head>
 <body>
  <h1>$PAGE_TITLE</h1>
  <p>This page was created by setup.sh, not by hand></p>
</body>
</html>
EOF

echo "Starting nginx... "
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Done! Visit: http://$(hostname -I | awk '{print $1}')"
