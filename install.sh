curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/Abdulwahaab710/dotFiles
ln -s ./dotFiles/.vim/init.vim ~/.config/nvim/init.vim
nvim -c 'so %|PlugInstall' ~/.vimrc
