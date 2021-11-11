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
  IPADDRESS=/sbin/ifconfig
  iptables -I FORWARD -d $IPADDRESS -j NFQUEUE --queue-num 1
fi
