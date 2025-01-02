#!/bin/bash

# Update and install dependencies
sudo yum update -y
sudo yum install -y aws-cli curl gcc-c++ make

# Switch to the ec2-user
su - ec2-user << 'EOF'

# Create the application directory
mkdir -p ~/app-tier

# Copy source code from S3
aws s3 cp s3://dev-3-tier-source-code-bucket/app-tier ~/app-tier --recursive

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc

# Install and use Node.js version 16
nvm install 16
nvm use 16

# Navigate to app directory and install dependencies
cd ~/app-tier
npm install -g pm2
npm install

# Modify DbConfig.js with DB credentials
# Replace placeholder with actual commands or script to configure DbConfig.js

# Start the application using PM2
pm2 start index.js

# List PM2 processes and configure it to start on boot
pm2 list
pm2 startup | bash

# Test the application
curl http://localhost:4000/health

EOF