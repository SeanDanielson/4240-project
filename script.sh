#!/bin/bash
#compile code
python3 main.py &
#run code
COMMAND=""
if [pgrep -x "$COMMAND"]
then
  killall COMMAND
else
  IPADDRESS=/sbin/ifconfig
  iptables -I INPUT -d $IPADDRESS -j NFQUEUE --queue-num 1
fi
