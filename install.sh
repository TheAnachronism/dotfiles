#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"

get_debian_version() {
  local version
  version=$(cat /etc/debian_version)
  if [[ $version == 11* ]]; then
    echo "11"
  elif [[ $version == 12* ]]; then
    echo "12"
  else
    echo "unknown"
  fi
}

print_error() {
  echo -e "\033[0;31m$1\033[0m"
}

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
    debian_version=$(get_debian_version)
    if [ "$debian_version" == "11" ]; then
      echo "Installing Nala for Debian 11"
      wget -O - https://deb.volian.org/volian/key.asc | sudo gpg --dearmor -o /usr/share/keyrings/volian-archive-keyring.gpg
      echo 'deb [signed-by=/usr/share/keyrings/volian-archive-keyring.gpg] https://deb.volian.org/volian scar main' | sudo tee /etc/apt/sources.list.d/volian.list
      sudo apt update
      sudo apt install nala -y
    elif [ "$debian_version" == "12" ]; then
      echo "Installing Nala for Debian 12+..."
      sudo apt install nala -y
    else
      print_error "Your Debian version is not supported for Nala installation."
    fi
  else
    echo "Nala is already installed."
  fi
}

install_tmux() {
  if ! command -v tmux &> /dev/null
  then
    echo "Tmux is not installed. Installing now..."
    sudo apt install tmux -y
  else
    echo "Tmux is already installed"
  fi
}

echo "Updating and upgrading your system..."
sudo apt update && sudo apt upgrade -y

install_tmux
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
