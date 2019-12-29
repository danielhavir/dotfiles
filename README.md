# dotfiles

Run:

```shell script
git clone https://github.com/danielhavir/dotfiles $HOME/dotfiles
cd $HOME/dotfiles/
bash setup.sh
cd $HOME
rm -rf dotfiles/
```

Or alternatively single line setup:
```shell script
curl -fsSL https://danielhavir.github.io/setup.sh | sh
```

#### Fish

* [Install Fish](https://fishshell.com/)
* [Install Fisher](https://github.com/jorgebucaran/fisher)
```shell script
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fisher add edc/bass
```
* [Setup Conda for Fish](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html#using-with-fish-shell) - `conda init fish`

#### ZShell

* Install Oh-My-Zsh
```shell script
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
* Change theme `ZSH_THEME="risto"`