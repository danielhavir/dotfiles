#!/bin/bash

set -e

IN_DOCKER=0
WITH_FISH=0
WITH_K8S=0
WITH_GO=0
WITH_RUST=0
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
      WITH_FISH=1
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
    --with-rust|--with_rust)
      WITH_RUST=1
      shift
      ;;
    --with-node|--with_node)
      WITH_NODE=1
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
    if [[ $EUID -eq 0 ]]
    then
      echo "${red}${bold}Running as $(whoami), sleeping for 10, hope you know what you're doing...${reset}"
      sleep 10
      apt-get install -y sudo
    fi
    # set timezone to prevent tzdata in Docker from freezing
    ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
    echo "America/Los_Angeles" > /etc/timezone
  fi
  profilefile="$HOME/.bashrc"
  echo "Known OS: $os => using $profilefile"
  sudo apt-get install -y software-properties-common tmux

  if [ $WITH_FISH = 1 ]
  then
    ./utils/install_fish.sh || echo "${red}could not install fish, skipping.${reset}"
  fi
  ./utils/install_vim.sh || echo "${red}could not install vim, skipping.${reset}"
  if [ $WITH_GO = 1 ]
  then
    ./utils/install_go.sh || echo "${red}could not install go, skipping.${reset}"
  fi
  if [ $WITH_RUST = 1 ]
  then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh || echo "${red}could not install rust, skipping.${reset}"
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
  if [ $WITH_GO = 1 ]
  then
    ./utils/install_go.sh || echo "${red}could not install go, skipping.${reset}"
  fi
  if [ $WITH_RUST = 1 ]
  then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh || echo "${red}could not install rust, skipping.${reset}"
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

# Setup .vimrc
if [ $WITH_NODE = 1 ]
then
  ./utils/install_vimrc.sh --include_coc
else
  ./utils/install_vimrc.sh
fi

if [ $IN_DOCKER = 1 ]; then
  # If running in Docker/container, change colorscheme in .vimrc
  sed -i 's/colorscheme darcula/colorscheme gotham/' "$HOME/.vimrc"
  # Comment out darcula colorscheme in .vimrc
  sed -i 's/Plug '\''doums\/darcula'\''/\" Plug '\''doums\/darcula'\''/' "$HOME/.vimrc"
  # Uncomment gotham colorscheme in .vimrc
  sed -i 's/\" Plug '\''whatyouhide\/vim-gotham'\''/Plug '\''whatyouhide\/vim-gotham'\''/' "$HOME/.vimrc"
fi

# Run PlugInstall non-interactively
vim -E -u ~/.vimrc +PlugInstall +qall > /dev/null 2>&1
echo "${magenta}${bold}vim-plug plugins installed${reset}"

if [ $WITH_FISH = 1 ]
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
