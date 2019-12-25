#!/bin/bash
set -e

os=$(uname)

if [ "$os" == "Linux" ]
then
  echo "OS: $os"
  profilefile="$HOME/.bashrc"
elif [ "$os" == "Darwin" ]
then
  echo "OS: $os"
  profilefile="$HOME/.bash_profile"
else
  echo "Unknown OS: $os"
  exit 0
fi

#sed -i "1s;^;$(cat bash_profile)\n;" $profilefile

# Copy aliases to profile file
{
  echo
  cat aliases.sh
  echo
} >> "$profilefile"

# Copy SSH configuration
mkdir -p ".ssh/"
touch ".ssh/config"
cat ssh/config >> ".ssh/config"

# Copy VIM configuration
cp vimrc "$HOME/.vimrc"

# Copy configuration for Fish shell
fish_home="$HOME/.config/fish"
mkdir -p "$fish_home"
cp config/fish/* "$fish_home"
