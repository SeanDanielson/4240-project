#!/bin/bash

#program will be running under this name
COMMAND="HttpFilter"
#checks if program is running
if pgrep -x $COMMAND
#if program is running, kill/quit the program and clear iptables
then
  killall $COMMAND
  sudo iptables -F
#if the programm is not running, run program
else
#get local IP address
  IPADDRESS=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')  
#Send all packets coming in and going out of the local machine to a queue before being processed
  iptables -I OUTPUT -d $IPADDRESS/24 -j NFQUEUE --queue-num 1
  iptables -I INPUT -d $IPADDRESS/24 -j NFQUEUE --queue-num 1  
#run program
  python3 main.py &
fi
