#!/bin/bash
#compile code
python3 main.py &
#run code
iptables -I INPUT -d 192.168.0.0/24 -j NFQUEUE --queue-num 1
