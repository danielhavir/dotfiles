#!/bin/bash
# Resource 1: https://golang.org/doc/install#install
# Resource 2: https://alexatnet.com/install-go-on-raspberry-pi/

set -e

version="1.16.2"
machine=$(uname -m)
os=$(uname)

bold=$(tput bold)
yellow=$(tput setaf 3)
green=$(tput setaf 2)
reset=$(tput sgr0)

if [ "$machine" == "armv7l" ]
then
    echo "Arch: $machine"
    tarfile="go$version.linux-armv6l.tar.gz"
elif [ "$machine" == "x86_64" ]
then
    if [ "$os" == "Linux" ]
    then
        echo "Arch: $os $machine"
        tarfile="go$version.linux-amd64.tar.gz"
    elif [ "$os" == "Darwin" ]
    then
        echo "Arch: $os $machine"
        tarfile="go$version.darwin-amd64.tar.gz"
    fi
else
    tput setaf 1; tput bold; echo "Unknown CPU architecture $machine"; tput sgr0
    echo "Visit https://golang.org/dl/"
    exit 0
fi
echo "####"

url="https://dl.google.com/go/$tarfile"
echo "${bold}Downloading${reset} $url"
if [ "$os" == "Linux" ]
then
  sudo apt-get install -y wget
fi
wget $url
echo "####"

# The following command needs sudo privileges
echo "Extracting $tarfile, sudo privileges required:"
sudo tar -C /usr/local -xzf $tarfile
echo "####"

echo "${green}Go successfully installed${reset}"
echo "Export PATH ${bold}export PATH=\$PATH:/usr/local/go/bin${reset}"
echo "Export PATH (Fish shell) ${bold}set PATH \$PATH /usr/local/go/bin${reset}"
echo "To set path automatically on next login, add ${yellow}${bold}export PATH=\$PATH:/usr/local/go/bin${reset} to ${yellow}${bold}~/.profile${reset}"

# Remove the tar file
rm -f $tarfile
