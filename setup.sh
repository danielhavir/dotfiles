#!/bin/bash

set -e

os=$(uname)

if [ "$os" == "Linux" ]
then
  profilefile="$HOME/.bashrc"
  echo "Known OS: $os => using $profilefile"
  ./utils/install_fish.sh || echo "could not install fish, skipping."
  ./utils/install_vim.sh || echo "could not install vim, skipping."
  ./utils/install_node.sh || echo "could not install nodejs (for coc), skipping."
elif [ "$os" == "Darwin" ]
then
  profilefile="$HOME/.bash_profile"
  brew install the_silver_searcher || echo "brew not installed, skipping."
  echo "Known OS: $os => using $profilefile"
else
  tput setaf 1
  tput bold
  echo "Unknown OS: $os"
  tput sgr0
  exit 1
fi

if [ ! -f "$profilefile" ]
  then
    tput setaf 1
    tput bold
    echo "Profile file $profilefile does not exist in OS $os"
    tput sgr0
    exit 1
fi

# Create profile file backup
cp "$profilefile" "$profilefile.backup"

# Prepend basic config to profile file
echo -e "$(cat bash_profile)\n\n$(cat "$profilefile")" > "$profilefile"

# Copy aliases to profile file
{
  echo
  cat aliases.sh
  echo
  cat kubernetes-helpers.sh
  echo
} >> "$profilefile"

# Copy SSH configuration
mkdir -p "$HOME/.ssh/"
touch "$HOME/.ssh/config"
cat ssh/config >> "$HOME/.ssh/config"

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
tput setaf 5
tput bold
echo "vim-plug set up, run \":PlugInstall\" in Vim"
tput sgr0

# Setup .vimrc
./install_vimrc.sh

# Copy configuration for Fish shell
fish_home="$HOME/.config/fish"
mkdir -p "$fish_home"
cp config/fish/* "$fish_home"

# Install Fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Copy JSON IO helpers
cp jsonio.py "$HOME"

# Copy and source TMUX config
cp tmux.conf "$HOME/.tmux.conf"
tmux source-file "$HOME/.tmux.conf"

tput setaf 2
tput bold
echo "Finished setup. Source file $profilefile"
tput sgr0
