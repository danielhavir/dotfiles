#!/bin/bash

set -e

IN_DOCKER=0
SKIP_FISH=0
WITH_K8S=0
LINK_VIMRC=0
WITH_GO=0
WITH_NODE=0

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    --in-docker|--in_docker)
      IN_DOCKER=1
      shift
      ;;
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

red=$(tput setaf 1)
green=$(tput setaf 2)
magenta=$(tput setaf 5)
bold=$(tput bold)
reset=$(tput sgr0)

if [ "$os" == "Linux" ]
then
  if [ $IN_DOCKER = 1 ]
  then
    echo "${magenta}${bold}Running setup script in Docker${reset}"
    if [[ $EUID -ne 0 ]]
    then
      echo "${red}${bold}Running as $(whoami), hope you know what you're doing...${reset}"
      apt-get install -y sudo
    fi
  fi
  profilefile="$HOME/.bashrc"
  echo "Known OS: $os => using $profilefile"
  sudo apt-get install -y software-properties-common

  if [ $SKIP_FISH = 0 ]
  then
    ./utils/install_fish.sh || echo "${red}could not install fish, skipping.${reset}"
  fi
  ./utils/install_vim.sh || echo "${red}could not install vim, skipping.${reset}"
  if [ $WITH_GO = 1 ]
  then
    ./utils/install_go.sh || echo "${red}could not install go, skipping.${reset}"
  fi
  if [ $WITH_NODE = 1 ]
  then
    ./utils/install_node.sh || echo "${red}could not install nodejs (for coc), skipping.${reset}"
  fi
  sudo apt-get install -y silversearcher-ag || echo "${red}could not install Ag, skipping.${reset}"
elif [ "$os" == "Darwin" ]
then
  if [ $IN_DOCKER = 1 ]
  then
    echo "${red}${bold}Setup in Docker for $os is not supported ${reset}"
    exit 1
  fi
  profilefile="$HOME/.bash_profile"
  brew install the_silver_searcher || echo "${red}brew not installed, skipping.${reset}"
  echo "Known OS: $os => using $profilefile"
else
  echo "${red}${bold}Unknown OS: $os${reset}"
  exit 1
fi

if [ ! -f "$profilefile" ]
  then
    echo "${red}${bold}Profile file $profilefile does not exist in OS $os${reset}"
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
echo "${magenta}${bold}vim-plug set up, run \":PlugInstall\" in Vim${reset}"

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
if ! tmux source-file "$HOME/.tmux.conf" &> /dev/null
then
  echo "${magenta}tmux not installed, source $HOME/.tmux.conf later${reset}"
fi

echo "${green}${bold}Finished setup. Source file $profilefile${reset}"
