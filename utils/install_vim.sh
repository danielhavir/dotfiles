#!/bin/bash

set -e

sudo add-apt-repository ppa:jonathonf/vim -y
sudo apt-get update
sudo apt-get purge -y vim
sudo apt-get -y autoremove
sudo apt-get install -y vim
