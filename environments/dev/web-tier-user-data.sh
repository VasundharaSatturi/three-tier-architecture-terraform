#!/bin/bash

# Switch to ec2-user
sudo su ec2-user <<'EOF'

# Install NVM and set up Node.js environments
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm install 16
nvm use 16

# Copy source code and configuration from S3
aws s3 cp s3://dev-3-tier-source-code-bucket/web-tier/ ~/web-tier --recursive
aws s3 cp s3://dev-3-tier-source-code-bucket/nginx.conf ~

# Navigate to the web-tier directory and build the application
cd ~/web-tier
npm install
npm run build

EOF

# Install and configure Nginx
sudo yum install nginx -y
sudo cp /home/ec2-user/nginx.conf /etc/nginx/
sudo systemctl enable nginx
sudo systemctl restart nginx

# Set appropriate permissions for the ec2-user home directory
sudo chmod -R 755 /home/ec2-user

# Health check to ensure the setup is successful
curl localhost/health
