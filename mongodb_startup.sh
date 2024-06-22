#!/bin/bash
apt-get update
apt-get install gnupg curl unzip
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
apt-get update
apt-get install -y mongodb-org
systemctl start mongod
systemctl enable mongod

curl https://raw.githubusercontent.com/lwsporcello/startup-scripts/main/createUser.js -o /createUser.js
sleep 5
mongosh < /createUser.js

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
bash ./aws/install

aws configure set aws_access_key_id "AKIAZD4SIT5MDSW6XR6W"
aws configure set aws_secret_access_key "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"
aws configure set region "us-east-1"

