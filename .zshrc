export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(git)
plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export TERM
export PATH
alias ll='ls -lGaf'
alias py='python'
alias tmux='tmux -2'
export TERM="xterm-256color"
if [ -n $TMUX ]; then
   alias vim="TERM=screen-256color vim"
fi
