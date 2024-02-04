#!/bin/bash

set -e

os=$(uname)
VIMRC="$HOME/.vimrc"

LINK_FILES=0

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -ln|--link)
      LINK_FILES=1
      shift
      ;;
    *)
      echo "Unknown option $1"
      shift
      ;;
esac
done

if [ -f "$VIMRC" ]; then
  cp $VIMRC "$HOME/.vimrc.copy"
fi

mkdir -p "$HOME/.vim/tmp/swap/"
mkdir -p "$HOME/.vim/tmp/backup/"

if [ $LINK_FILES = 1 ]
then
  echo "Linking vimrc files"
  rm -rf "$HOME/.config/vim/"
  mkdir -p "$HOME/.config"
  cp -r config/vim/ "$HOME/.config/vim"
  cp vimrc $VIMRC
else
  echo "Concatenating vimrc files"
  rm -f $VIMRC
  VIM_DIR="config/vim"
  VIM_PLUGIN_DIR="$VIM_DIR/plugins"
  VIMRC_FILES=(
    "$VIM_DIR/bundles.vim"
    "$VIM_DIR/autocmd.vim"
    "$VIM_DIR/settings.vim"
    "$VIM_DIR/keymapping.vim"
    "$VIM_PLUGIN_DIR/coc.vim"
    "$VIM_PLUGIN_DIR/codeium.vim"
    "$VIM_PLUGIN_DIR/ctrlp.vim"
    "$VIM_PLUGIN_DIR/flake.vim"
    "$VIM_PLUGIN_DIR/nerdcomment.vim"
    "$VIM_PLUGIN_DIR/nerdtree.vim"
    "$VIM_PLUGIN_DIR/simpylfold.vim"
    "$VIM_PLUGIN_DIR/vim-go.vim"
  )

  if [ "$os" == "Linux" ]
  then
    VIMRC_FILES+=("$VIM_PLUGIN_DIR/ycm.vim")
  fi

  VIMRC_FILES+=("$VIM_DIR/color.vim")

  if [ -f "$HOME/.vimrc.local" ]
  then
    VIMRC_FILES+=("$HOME/.vimrc.local")
  fi

  for file in "${VIMRC_FILES[@]}"
  do
    {
      cat $file
      echo
    } >> "$VIMRC"
  done
fi

tput setaf 2
echo "Set up vimrc successfully"
tput sgr0
