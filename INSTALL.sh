#!/bin/bash
sudo dnf install git -y &>/dev/null
sudo mkdir -p /tmp/sh &>/dev/null
sudo chmod 777 /tmp/sh  &>/dev/null
git clone https://github.com/infinitelearning-ibmacademy-hcrh/compreview1-5.git /tmp/sh &>/dev/null
sudo cp /tmp/sh/lab.sh /usr/bin/lab &>/dev/null
sudo chmod a+x /usr/bin/lab &>/dev/null
sudo rm -rf /tmp/sh &>/dev/null
useradd student &>/dev/null
echo "student" | passwd --stdin student 
su - student 
echo -e "\e[1;42;97m LAB INSTALLED, YOU CAN LAB START NOW !! \e[0m"
echo ""
