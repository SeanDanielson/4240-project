#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt-get install build-essential python-dev libnetfilter-queue-dev
sudo pip3 install NetfilterQueue
sudo pip3 install setproctitle

