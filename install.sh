#/bin/bash

# installing vim plug
echo -ne ">> Installing vim plug\r"
sleep 1
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -ne ">>                               \r"
echo -ne ">> clone the dot files directory\r"
sleep 1
# git clone https://github.com/Abdulwahaab710/dotFiles

# backing up vim
echo -ne ">>                               \r"
echo -ne ">> Backing up vim\r"
sleep 1
# backupDir=$($HOME)/dotFilesBackup
# mkdir -p $backupDir
# mv $HOME/.vim $backupDir/.vim

# Linking dotFiles
dotFiles=".vimrc .vimrc_c++ .vimrc_java .zshrc .khdrc .kwm myFunctions.vim"
for dotFile in $dotFiles;
do
  echo -ne ">>                               \r"
  echo -ne ">> Linking "$dotFile"\r"
  sleep 1
  # ln -s ./dotFiles/$dotFile $dotFile
done

echo -ne ">>                               \r"
echo -ne ">> Installing vim plugins\r"
sleep 1
# vim -c 'so %|PlugInstall|qa' ~/.vimrc
