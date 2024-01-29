#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"

install_oh_my_zsh() {
  # Install Oh-My-Zsh
  if [ ! -d "$HOME/.oh-my-zsh/" ] 
  then
    echo "Installing Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "Oh-My-Zsh is already installed."
  fi
}

echo "Updating and upgrading your system..."
sudo apt update && sudo apt upgrade -y

if ! command -v zsh &> /dev/null
then
  echo "ZSH is not installed. Installing now..."
  sudo apt install zsh -y
else
  echo "ZSH is already installed."
fi

# Set ZSH as default shell
chsh -s $(which zsh)

install_oh_my_zsh

# Setting up the custom .zshrc file
cp $DOTFILES_DIR/zshrc $HOME/.zshrc

# Dotfiles are complete.
