#!/bin/bash

sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get update
sudo apt-get purge -y vim
sudo apt-get -y autoremove
sudo apt-get -y vim
