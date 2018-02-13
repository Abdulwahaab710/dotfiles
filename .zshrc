#
# export TERM="xterm-256color"
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
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true # POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%\u2570%F{cyan} ❯%F{073}❯%F{109}❯%f "


# Customize to your needs...

# Start rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/dev/python/ocTerminal:$PATH"
# eval "$(rbenv init -)"

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
export EDITOR="nvim"
export GIT_EDITOR=nvim

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

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "supercrabtree/k"

alias fix='rm ~/.zcondump*;exec zsh;'

# export TERM
# export PATH

##########################
# Aliases
##########################
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


# ============
# GIT ALIASES
# ============
alias add='git add'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit'
alias prebase='git pull rebase'
alias pull='git pull'
alias push='git push'
alias stash='git stash'
alias status='git status'

alias k='kubectl'
alias rtest='bundle exec rspec'
alias s='fast_git_branch_select'
alias ts='fast_tmux_session_select'
alias gpu='push_upstram_origin'
alias ccat='/bin/cat'
alias cat='/usr/local/bin/ccat'
alias mk='make'
alias v='nvim'
alias kali='docker run -it --rm kalilinux/kali-linux-docker'
alias ubuntu='docker run -it --rm dockerfile/ubuntu'
alias mkube='minikube'
alias sp='switch_project'
alias rspec='bundle exec rspec'
alias swap='swap_file_names'
# Cheat => enabling syntax highligthing
export CHEATCOLORS=true
export EDITOR=nvim

# kubectl autocomplete
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
if [ ! -f $HOME/$TERM.ti  ]; then
    infocmp $HOME/$TERM.ti | sed 's/kbs=^[hH]/kbs=\\177/' > $HOME/$TERM.ti
    tic $HOME/$TERM.ti
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$PATH:/Applications/nwjs.app/Contents/MacOS

###########################
# Functions
###########################
function print_welcome {
    clear
    fortune | cowsay -f dragon-and-cow | cat
}
print_welcome
function fast_git_branch_select {
    branch="$(git branch | fzf-tmux -d 15)"
    BRANCH_NAME="$(echo -e "${branch}" | sed -e 's/^[[:space:]]*//')"
    git checkout $BRANCH_NAME
}

function fast_tmux_session_select {
    session="$(tmux ls | fzf-tmux -d 15)"
    SESSION_NAME="$(echo -e "${session}" | sed -e 's/^[[:space:]]*//' | sed -e 's/: .*//')"
    tmux attach -t $SESSION_NAME
}

function git-nvim {
    git status -s -u | fzf -m --ansi --preview-window "right:33%" --preview "echo {} | cut -d' ' -f 3 | xargs head -$LINES" | cut -d' ' -f 3 | xargs nvim
}

function push_upstram_origin {
    BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
    git push origin -u $BRANCH_NAME
}

function switch_project {
    PROJECT_NAME="$(l ~/src/github.com/Shopify | fzf)"
    cd "$HOME/src/github.com/Shopify/$PROJECT_NAME"
}

function swap_file_names {
    first_file=$1
    second_file=$2
    tmp_name="tmp:$first_file+$second_file"
    mv $first_file $tmp_name
    mv $second_file $first_file
    mv $tmp_name $second_file
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/abdulwahaabahmed/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/abdulwahaabahmed/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/abdulwahaabahmed/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/abdulwahaabahmed/google-cloud-sdk/completion.zsh.inc'; fi
