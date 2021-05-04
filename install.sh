sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -s ./dotFiles/.vim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/zshrc ~/.zshrc
nvim -c 'so %|PlugInstall' ~/.vimrc
