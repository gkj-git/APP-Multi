#!/bin/bash

sudo apt-get update -y 
sudo apt-get install -y docker.io


sudo systemctl enable docker 

sudo docker run -d --name multiverse -p 3000:3000 multiverse/mulitverse:latest