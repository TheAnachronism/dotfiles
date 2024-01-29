#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"

install_oh_my_zsh() {
  # Install Oh-My-Zsh
  if [ ! -d "$HOME/.oh-my-zsh/" ] 
  then
    echo "Installing Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    echo "Oh-My-Zsh is already installed."
  fi
}

install_nala() {
  if ! command -v nala &> /dev/null
  then
    echo "Nala is not installed. Installing now..."
    echo "Adding Nala repository..."
    echo 'deb http://deb.volian.org/volian/ scar main' | sudo tee /etc/apt/sources.list.d/nala.list
    wget -qO - http://deb.volian.org/volian/key.gpg | sudo apt-key add -
    sudo apt update
    sudo apt install nala -y
  else
    echo "Nala is already installed."
  fi
}

echo "Updating and upgrading your system..."
sudo apt update && sudo apt upgrade -y

install_nala

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
