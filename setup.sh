#!/bin/bash
set -e

os=$(uname)

if [ "$os" == "Linux" ]
then
  echo "OS: $os"
  sourcefile="$HOME/.bashrc"
elif [ "$os" == "Darwin" ]
then
  echo "OS: $os"
  sourcefile="$HOME/.bash_profile"
else
  echo "Unknown OS: $os"
  exit 0
fi

#sed -i "1s;^;$(cat bash_profile)\n;" $sourcefile

{
  echo
  cat aliases.sh
  echo
} >> "$sourcefile"

cp vimrc "$HOME/.vimrc"
