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

print_info() {
  echo -e "\033[0;036m$1\033[0m"
}

print_error() {
  echo -e "\033[0;31m$1\033[0m"
}

print_success() {
  echo -e "\033[0;032m$1\033[0m"
}

install_oh_my_zsh() {
  # Install Oh-My-Zsh
  if [ ! -d "$HOME/.oh-my-zsh/" ] 
  then
    print_info "Installing Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    print_success "Oh-My-Zsh is already installed."
  fi
}

install_nala() {
  if ! command -v nala &> /dev/null
  then
    print_info "Nala is not installed. Installing now..."
    debian_version=$(get_debian_version)
    if [ "$debian_version" == "11" ]; then
      print_info "Installing Nala for Debian 11"
      curl -O https://gitlab.com/volian/volian-archive/uploads/b20bd8237a9b20f5a82f461ed0704ad4/volian-archive-keyring_0.1.0_all.deb 
      curl -O https://gitlab.com/volian/volian-archive/uploads/4ba4a75e391aa36f0cbe7fb59685eda9/volian-archive-scar_0.1.0_all.deb
      sudo apt install -y ./volian-archive-*.deb
      sudo apt update
      sudo apt install man nala -y
      rm -r ./volian-archive-*.deb
    elif [ "$debian_version" == "12" ]; then
      print_info "Installing Nala for Debian 12+..."
      sudo apt install nala -y
    else
      print_error "Your Debian version is not supported for Nala installation."
    fi
  else
    print_success "Nala is already installed."
  fi
}

install_tmux() {
  if ! command -v tmux &> /dev/null
  then
    print_info "Tmux is not installed. Installing now..."
    sudo apt install tmux -y
  else
    print_success "Tmux is already installed"
  fi
}

install_homebrew() {
  if ! command -v brew &> /dev/null
  then
    print_info "Homebrew is not installed. Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    export PATH=/home/linuxbrew/.linuxbrew/bin/:$PATH
  else
    print_success "Homebrew is already installed."
  fi
}

install_neovim() {
  if ! command -v nvim &> /dev/null
  then
    print_info "Neovim is not installed. Installing now..."
    sudo apt install -y gcc
    brew install neovim
    print_success "Neovim installed, installing nvchad..."
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
    print_success "NVChad successfully installed."
  else
    print_success "Neovim is already installed."
  fi
}

print_info "Updating and upgrading your system..."
sudo apt update && sudo apt upgrade -y && apt install -y gpg

install_homebrew
install_tmux
install_nala

if ! command -v zsh &> /dev/null
then
  print_info "ZSH is not installed. Installing now..."
  sudo apt install zsh -y
else
  print_success "ZSH is already installed."
fi

# Set ZSH as default shell
chsh -s $(which zsh)

install_oh_my_zsh
install_neovim

# Copying neovim custom configs.
cp -r $DOTFILES_DIR/nvim/custom ~/.config/nvim/lua/

# Setting up the custom .zshrc file
cp $DOTFILES_DIR/zshrc $HOME/.zshrc

# Dotfiles are complete.
print_success "Dotfiles successfully installed."
zsh
