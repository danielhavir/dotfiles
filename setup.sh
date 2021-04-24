#!/bin/bash

set -e

SKIP_FISH=0
WITH_K8S=0
LINK_VIMRC=0
WITH_GO=0
WITH_NODE=0

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    --skip-fish|--skip_fish)
      SKIP_FISH=1
      shift
      ;;
    --with-k8s|--with_k8s)
      WITH_K8S=1
      shift
      ;;
    --with-go|--with_go)
      WITH_GO=1
      shift
      ;;
    --with-node|--with_node)
      WITH_NODE=1
      shift
      ;;
    --link-vimrc|--link_vimrc)
      LINK_VIMRC=1
      shift
      ;;
    *)
      tput setaf 3
      echo "Unknown option $1"
      tput sgr0
      shift
      ;;
esac
done

os=$(uname)

if [ "$os" == "Linux" ]
then
  profilefile="$HOME/.bashrc"
  echo "Known OS: $os => using $profilefile"
  if [ $SKIP_FISH = 0 ]
  then
    ./utils/install_fish.sh || echo "could not install fish, skipping."
  fi
  ./utils/install_vim.sh || echo "could not install vim, skipping."
  if [ $WITH_GO = 1 ]
  then
    ./utils/install_go.sh
  fi
  if [ $WITH_NODE = 1 ]
  then
    ./utils/install_node.sh || echo "could not install nodejs (for coc), skipping."
  fi
  sudo apt-get install -y silversearcher-ag || echo "could not install Ag, skipping."
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
} >> "$profilefile"

if [ $WITH_K8S = 1 ]
then
  echo "Adding K8s helpers to $profilefile"
  {
    cat kubernetes-helpers.sh
    echo
  } >> "$profilefile"
fi

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
if [ $LINK_VIMRC = 1 ]
then
  ./utils/install_vimrc.sh --link
else
  ./utils/install_vimrc.sh
fi

if [ $SKIP_FISH = 0 ]
then
  # Copy configuration for Fish shell
  fish_home="$HOME/.config/fish"
  mkdir -p "$fish_home"
  cp config/fish/* "$fish_home"

  # Install Fisher
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fi

# Copy JSON IO helpers
cp jsonio.py "$HOME"

# Copy and source TMUX config
cp tmux.conf "$HOME/.tmux.conf"
tmux source-file "$HOME/.tmux.conf"

tput setaf 2
tput bold
echo "Finished setup. Source file $profilefile"
tput sgr0
