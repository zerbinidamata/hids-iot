#!/bin/sh

# Kill mirai port
kill -9 $(lsof -t -i tcp:48101)

# Change password
MAC=`ip a | grep link/ether | awk -F " " '{print $2}'`
IP=`hostname -i`
SALT=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1`
PWD=`echo -n ${MAC}:${IP}:${SALT} | md5sum`


echo `pi:${PWD}` | chpasswd

# Reboot device after 10 minutes, gives time for the test_case to be reran   
shutdown -r +10 

