mkdir -p "$HOME/.config/nvim"

# Install neovim 0.5
if [ -f "/usr/bin/apt" ]; then
  sudo add-apt-repository ppa:neovim-ppa/unstable -y && sudo apt-get update -y && sudo apt-get install neovim -y
fi

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -s $HOME/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim
ln -s $HOME/dotfiles/nvim/lua $HOME/.config/nvim/lua

zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

export ZPLUG_HOME=$HOME/.zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME

ln -fs "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
ln -fs "$HOME/dotfiles/.zprezto" "$HOME/.zprezto"
ln -fs "$HOME/dotfiles/.aliases" "$HOME/.aliases"
ln -fs "$HOME/dotfiles/.pk10.zsh" "$HOME/.pk10.zsh"

nvim -c 'so %|PlugInstall' $HOME/.config/nvim/init.vim
