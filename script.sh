#!/bin/bash
#compile code
#python3 main.py &
#run code
COMMAND="HttpFilter"
if pgrep -x $COMMAND
then
  killall $COMMAND
  sudo iptables -F
else
  IPADDRESS=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
  iptables -I OUTPUT -d $IPADDRESS/24 -j NFQUEUE --queue-num 1
  iptables -I INPUT -d $IPADDRESS/24 -j NFQUEUE --queue-num 1
  python3 main.py &
fi
