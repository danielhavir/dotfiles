#!/bin/bash
# Resource 1: https://julialang.org/downloads/

set -e

major="1.5"
minor="1.5.3"
machine=$(uname -m)

bold=$(tput bold)
yellow=$(tput setaf 3)
green=$(tput setaf 2)
normal=$(tput sgr0)

if [ "$machine" == "x86_64" ]
then
    os=$(uname | awk '{print tolower($0)}')
    if [ "$os" == "linux" ]
    then
        echo "Arch: $os $machine"
        tarfile="julia-$minor-$os-$machine.tar.gz"
        url="https://julialang-s3.julialang.org/bin/$os/x64/$major/$tarfile"
    elif [ "$os" == "darwin" ]
    then
        echo "Arch: $os $machine"
        dmgfile="julia-$minor-mac64.dmg"
        url="https://julialang-s3.julialang.org/bin/mac/x64/$major/$dmgfile"
        wget $url
        echo "${green}Julia downloaded${normal}"
        echo "Open $dmgfile to install"
        exit 0
    fi
else
    tput setaf 1; tput bold; echo "Unknown CPU architecture $machine"; tput sgr0
    echo "Visit https://julialang.org/downloads/"
    exit 0
fi
echo "####"

echo "${bold}Downloading${normal} $url"
wget $url
echo "####"

# The following command needs sudo privileges
echo "Extracting $tarfile, sudo privileges required."
sudo tar -C /usr/local -xzf $tarfile
echo "Creating symlink, sudo privileges required."
sudo ln -s "/usr/local/julia-$minor/bin/julia" /usr/local/bin/julia
echo "####"

# Remove the tar file
rm -f $tarfile
