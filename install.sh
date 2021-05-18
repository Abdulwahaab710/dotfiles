mkdir -p $HOME/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -fs $HOME/dotfiles/.vim/init.vim $HOME/.config/nvim/init.vim
nvim -c 'so %|PlugInstall' $HOME/.config/nvim/init.vim
