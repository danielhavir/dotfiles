#!/bin/bash

set -e

sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo apt-get update
sudo apt-get install -y fish
