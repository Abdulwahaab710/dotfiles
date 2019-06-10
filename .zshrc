if [ -f $HOME/xterm-256color-italic.ti ]; then
  export TERM="xterm-256color-italic"
else
  export TERM="xterm-256color"
fi

# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# Customize to your needs...
export LANG="en_US.UTF-8"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(rspec_stats chruby vi_mode status background_jobs)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}\u256D\u2500%f"


# Customize to your needs...

# Add homebrew to the completion path
fpath=("/usr/local/bin/" $fpath)

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# Now we can pipe to multiple outputs!
setopt MULTIOS

# This makes cd=pushd
setopt AUTO_PUSHD

# This will use named dirs when possible
setopt AUTO_NAME_DIRS

# If we have a glob this will expand it
setopt GLOB_COMPLETE
setopt PUSHD_MINUS

# No more annoying pushd messages...
# setopt PUSHD_SILENT

# blank pushd goes to home
setopt PUSHD_TO_HOME

# this will ignore multiple directories for the stack.  Useful?  I dunno.
setopt PUSHD_IGNORE_DUPS

# 10 second wait if you do something that will delete everything.  I wish I'd had this before...
setopt RM_STAR_WAIT

# use magic (this is default, but it can't hurt!)
setopt ZLE

setopt NO_HUP

# only fools wouldn't do this ;-)
export EDITOR="/usr/local/bin/nvim"
export GIT_EDITOR="/usr/local/bin/nvim"

setopt IGNORE_EOF

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# Keep echo "station" > station from clobbering station
setopt NO_CLOBBER

# Case insensitive globbing
setopt NO_CASE_GLOB

# Be Reasonable!
setopt NUMERIC_GLOB_SORT

# I don't know why I never set this before.
setopt EXTENDED_GLOB

# hows about arrays be awesome?  (that is, frew${cool}frew has frew surrounding all the variables, not just first and last
setopt RC_EXPAND_PARAM

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# Incremental search is elite!
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward

# Search based on what you typed in already
bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward

bindkey "\eOP" run-help

# oh wow!  This is killer...  try it!
bindkey -M vicmd "q" push-line

# it's like, space AND completion.  Gnarlbot.
bindkey -M viins ' ' magic-space

# zsh-autosuggestions
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Zplug {{{
  export ZPLUG_HOME=/usr/local/opt/zplug
  if [[ ! -d $ZPLUG_HOME ]]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
    source $ZPLUG_HOME/init.zsh
  else
    source $ZPLUG_HOME/init.zsh
  fi
  zplug "supercrabtree/k"
  zplug "zdharma/fast-syntax-highlighting",  defer:3
  zplug "zsh-users/zsh-autosuggestions",     defer:3

  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      else
          echo
      fi
  fi

  zplug load

# }}}

# aliases ---------------------------------------------{{{{

alias fix='rm ~/.zcondump*;exec zsh;'

alias k=kubectl
alias d=docker
alias rtest='bundle exec rspec'
alias gpu=push_upstram_origin
alias mk=make
alias v=nvim
alias kali='docker run -it --rm kalilinux/kali-linux-docker'
alias ubuntu='docker run -it --rm dockerfile/ubuntu'
alias mkube='minikube'
alias rspec='bundle exec rspec'
alias rsa='railgun status -a -H -o name | xargs -n1 railgun stop'
alias ghp='open https://github.com/pulls'
alias tn='tmux new -s'

alias ll='exa -bghHliSFa'
alias py='python'
alias tmux='tmux -2'
alias startKwm='brew services start kwm'
alias stopKwm='brew services stop kwm'
alias gitset='git push --set-upstream'
if [ -n $TMUX  ]; then
    alias vim="TERM=screen-256color vim"
fi
alias disableChrome='defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE'
alias tf='terraform'
alias bsl='brew services list'
alias so='source'
alias o=open
alias sync_branches='git fetch --all --prune && git branch -vv --no-color | grep "\[.*: gone\]" | awk "{print \$1}" | xargs git branch -D'
source ~/.aliases

# dev -------------{{{{
alias dcl='dev clone'
# }}}}

# }}}}

# Cheat => enabling syntax highligthing
export CHEATCOLORS=true
export EDITOR=/usr/local/bin/nvim
export VISUAL=/usr/local/bin/nvim

# kubectl autocomplete
# if [ $commands[kubectl] ]; then
#   source <(kubectl completion zsh)
# fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
if [ ! -f $HOME/$TERM.ti  ]; then
    infocmp $HOME/$TERM.ti | sed 's/kbs=^[hH]/kbs=\\177/' > $HOME/$TERM.ti
    tic $HOME/$TERM.ti
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/abdulwahaabahmed/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/abdulwahaabahmed/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/abdulwahaabahmed/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/abdulwahaabahmed/google-cloud-sdk/completion.zsh.inc'; fi
export PATH=$PATH:$HOME/swap
export PATH="/usr/local/opt/python@2/bin:$PATH"
export PATH="$HOME/.config/zsh/fp:$PATH"
#Neovim true color support
export NVIM_TUI_ENABLE_TRUE_COLOR=1
# Neovim cursor shape support
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

# Added by Krypton
export GPG_TTY=$(tty)
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH
export KUBECONFIG=$HOME/.kube/config

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# functions -------------------------------------------{{{{
function update {
  sudo softwareupdate -i -a
  brew update
  brew upgrade --all
  brew cask upgrade --all
  brew cleanup
  sudo gem update --system
  sudo gem update
  $EDITOR -c 'PlugClean | PlugUpdate | PlugUpgrade' ~/.config/nvim/init.vim
}

function start {
  clear
  neofetch
}
start

function s {
    branch="$(git branch | fzf-tmux -d 15)"
    if [ ! -z $branch ]
    then
      BRANCH_NAME="$(echo -e "${branch}" | sed -e 's/^[[:space:]]*//')"
      git checkout $BRANCH_NAME
    fi
}

function ts {
    session="$(tmux ls | fzf-tmux -d 15)"
    if [ ! -z $session ]
    then
      SESSION_NAME="$(echo -e "${session}" | sed -e 's/^[[:space:]]*//' | sed -e 's/: .*//')"
      tmux attach -t $SESSION_NAME
    fi
}

function git-nvim {
    git status -s -u | fzf -m --ansi --preview-window "right:33%" --preview "echo {} | cut -d' ' -f 3 | xargs head -$LINES" | cut -d' ' -f 3 | xargs nvim
}

function push_upstram_origin {
    BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
    if [ ! -z $BRANCH_NAME ]
    then
      git push origin -u $BRANCH_NAME
    fi
}

function sp {
    PROJECT_NAME="$((cd $HOME/src/github.com; ls -dl1 * */*) | fzf-tmux -d 15)"
    if [ ! -z $PROJECT_NAME ]
    then
      cd "$HOME/src/github.com/$PROJECT_NAME"
    fi
}

function swap_file_names {
    first_file=$1
    second_file=$2
    tmp_name="tmp:$first_file+$second_file"
    mv $first_file $tmp_name
    mv $second_file $first_file
    mv $tmp_name $second_file
}

function dmenu_apps {
  APP_NAME=$(ls -1A /Applications | sed 's/\.app//g' | dmenu)
  if [ ! -z $APP_NAME ]
  then
    open -F -a $APP_NAME
  fi
}


unalias g 2>/dev/null
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

function rm_orig {
  find . -name *.orig | xargs rm
}

compdef g=git

function RANDOM_THEME {
  THEMES=($(alias | awk -F'=' '/base16_[A-Za-z0-9]*/ {print $1}'))
  THEMES_ARRAY_SIZE=${#THEMES[@]}
  THEME_INDEX=$(( ( RANDOM % THEMES_ARRAY_SIZE )  + 1 ))
  shopt $THEMES[$THEME_INDEX]
}

function brakeman_scan {
  chruby 2.5.1
  brakeman -o report.html
  open report.html
  sleep 2
  rm -rf report.html
}

function docker_clean_all {
  alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
  alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
  docker kill $(docker ps -q) 2>/dev/null
  docker_clean_ps 2>/dev/null
  docker_clean_images 2>/dev/null
  docker rmi $(docker images -a -q) 2>/dev/null
}
# function test_connection {
#   if [ $(ping 1.1.1.1 -c 4) -eq 0 ]; then
#     echo 'Your device is connectted to the internet'
#   fi
# }
# }}}}


# Bindkeys --------------------------------------------{{{
bindkey -s jj '\e'
# }}}
