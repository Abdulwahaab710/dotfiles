mkdir -p $HOME/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -s $HOME/dotfiles/nvim/init.vim $HOME/nconfig/nvim/init.vim
ln -s $HOME/dotfiles/nvim/lua $HOME/nconfig/nvim/lua
nvim -c 'so %|PlugInstall' $HOME/.config/nvim/init.vim
