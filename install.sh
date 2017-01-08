curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ./dotFiles/.vimrc ~/.vimrc
ln -s ./dotFiles/.vimrc_c++ ~/.vimrc_c++
ln -s ./dotFiles/.vimrc_python ~/.vimrc_python
ln -s ./dotFiles/.vimrc_java ~/.vimrc_java
vim -c 'so %|PlugInstall' ~/.vimrc
