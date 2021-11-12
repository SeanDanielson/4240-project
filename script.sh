#!/bin/bash
#compile code
#python3 main.py &
#run code
COMMAND="python3"
if pgrep -x $COMMAND
then
  killall $COMMAND
  sudo iptables -F
else
  IPADDRESS=$(hostname -I)
  iptables -I FORWARD -d $IPADDRESS/24 -j NFQUEUE --queue-num 1
  python3 main.py &
fi
