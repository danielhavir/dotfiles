#!/bin/bash

set -e

if [ "$(uname -m)" != "armv7l" ] && [ "$(uname -m)" != "armv6l" ]; then
  sudo add-apt-repository ppa:jonathonf/vim -y
  sudo apt-get update
  sudo apt-get purge -y vim
  sudo apt-get -y autoremove
fi
sudo apt-get install -y vim
