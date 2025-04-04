#! /bin/zsh

# Pretty print with colors and formatting [info, success, error]
# Usage: print_info STATUS MESSAGE
print_info() {
  printf "\e[0;34m[INFO]\e[0m $1\n"
}

print_success() {
  printf "\e[0;32m[SUCCESS]\e[0m $1\n"
}

print_error() {
  printf "\e[0;31m[ERROR]\e[0m $1\n"
}

print_warning() {
  printf "\e[0;33m[WARNING]\e[0m $1\n"
}

# Install and setup zsh
# Usage: install_zsh
# install_zsh() {
#   zsh
#   print_info "Cloning zprezto..."
#   git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
#   print_success "zprezto cloned successfully!"
#   print_info "Setting zsh as default shell..."
#   setopt EXTENDED_GLOB
#   for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#     ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
#   done
#   print_success "zsh set as default shell successfully!"
#   print_info "Setting zsh as default shell..."
#   chsh -s /bin/zsh
#   print_success "zsh set as default shell successfully!"
# }

# Install Homebrew
# Usage: install_homebrew
install_homebrew() {
  if command -v brew &> /dev/null; then
    print_info "Homebrew is already installed!"
    print_info "Updating Homebrew..."
    brew update
    print_success "Homebrew updated successfully!"
    print_info "Upgrading Homebrew..."
    brew upgrade
    print_success "Homebrew upgraded successfully!"
  else
    print_warning "Homebrew is not installed!"
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew installed successfully!"
  fi
}

# Install Homebrew packages
# Usage: install_homebrew_packages
install_homebrew_packages() {
  print_info "Installing Homebrew packages..."
  brew bundle
  print_success "Homebrew packages installed successfully!"
}

install_tpm() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Link dotfiles
# Usage: link_dotfiles
link_dotfiles() {
  print_info "Linking files for zsh"
  ln -fs "$PWD/.zshrc" "$HOME/.zshrc"
  ln -fs "$PWD/.zprezto" "$HOME/.zprezto"
  ln -fs "$PWD/.aliases" "$HOME/.aliases"
  print_success "zsh files linked successfully!"

  print_info "Linking files for inputrc"
  ln -fs "$PWD/.inputrc" "$HOME/.inputrc"
  print_success "inputrc files linked successfully!"

  print_info "Linking files for starship"
  ln -fs "$PWD/starship.toml" "$HOME/.config/starship.toml"
  print_success "starship files linked successfully!"


  install_tpm
  print_info "Linking files for tmux"
  ln -fs "$PWD/tmux" "$HOME/.config/tmux"
  print_success "tmux files linked successfully!"

  print_info "Linking files for nvim"
  ln -s "$PWD/nvim" "$HOME/.config/nvim"
  print_success "nvim files linked successfully!"

  print_info "Linking files for vifm"
  ln -fs "$PWD/vifm" "$HOME/.config/vifm"
  print_success "vifm files linked successfully!"

  print_info "Linking files for git"
  ln -fs "$PWD/.gitconfig" "$HOME/.gitconfig"
  ln -fs "$PWD/.gitignore" "$HOME/.gitignore"
  ln -fs "$PWD/.gitmodules" "$HOME/.gitmodules"
  print_success "git files linked successfully!"

  print_info "Linking files for aerospace"
  ln -fs "$PWD/aerospace" "$HOME/.config/aerospace"
  print_success "aerospace files linked successfully!"

  print_info "Linking files for sketchybar"
  ln -fs "$PWD/sketchybar" "$HOME/.config/sketchybar"
  print_success "sketchybar files linked successfully!"

  print_info "Linking files for hammerspoon"
  ln -fs "$PWD/.hammerspoon" "$HOME/.hammerspoon"
  print_success "hammerspoon files linked successfully!"

  print_info "Linking files for wezterm"
  ln -fs "$PWD/wezterm" "$HOME/.config/wezterm"
  print_success "wezterm files linked successfully!"
}

# Set up python virtual environment for neovim
# https://neovim.io/doc/user/provider.html#python-virtualenv
# Usage: setup_python_virtualenv_for_neovim
setup_python_virtualenv_for_neovim() {
  print_info "Setting up python virtual environment for neovim..."
  pyenv install 3.9.4
  pyenv virtualenv 3.9.4 py3nvim
  pyenv activate py3nvim
  python3 -m pip install pynvim --break-system-packages
  print_success "Python virtual environment for neovim set up successfully!"
}

# macos_system_preferences
# Usage: macos_system_preferences
macos_system_preferences() {
  print_info "Setting up macOS system preferences..."
  /bin/bash "$PWD/.system"
  print_success "macOS system preferences updated successfully!"
}

main() {
  # install_zsh
  install_homebrew
  install_homebrew_packages
  link_dotfiles
  macos_system_preferences
}

main
