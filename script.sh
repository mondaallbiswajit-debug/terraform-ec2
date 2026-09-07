#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
echo "hi bisu" | sudo tee /var/www/html/index.nginx-debian.html