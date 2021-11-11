#!/bin/bash
#compile code
python3 main.py &
#run code
COMMAND="python3"
if [pgrep -x "$COMMAND"]
then
  killall COMMAND
  sudo iptables -F
else
  IPADDRESS=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
  iptables -I FORWARD -d $IPADDRESS -j NFQUEUE --queue-num 1
fi
