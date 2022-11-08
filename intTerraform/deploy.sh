#!/bin/bash

sleep 120
sudo apt -y update 
sudo apt -y install git
sleep 3
git clone https://github.com/Hobsonkp/kuralabs_deployment_3.git
sleep 5
cd kuralabs_deployment_3/
sleep 3
sudo apt -y install python3
sleep 3
sudo apt -y install python3-pip
sleep 3
pip install -r requirements.txt
sleep 5
pip install gunicorn
sleep 5
python3 -m gunicorn -w 4 application:app -b 0.0.0.0 --daemon