if [ -f $HOME/xterm-256color-italic.ti ]; then
  export TERM="xterm-256color-italic"
else
  export TERM="xterm-256color"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# eval "$(starship init zsh)"

fpath+=~/.zfunc
fpath=("/usr/local/bin/" $fpath)

setopt AUTO_CD
setopt MULTIOS
setopt AUTO_PUSHD
setopt AUTO_NAME_DIRS
setopt GLOB_COMPLETE
setopt PUSHD_MINUS
setopt PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS
setopt RM_STAR_WAIT
setopt ZLE
setopt NO_HUP
setopt IGNORE_EOF
setopt NO_FLOW_CONTROL
setopt NO_CLOBBER
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB
setopt RC_EXPAND_PARAM

# Zinit -----------------------------------------------{{{{
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
# }}}}

eval "$(starship init zsh)"

# aliases ---------------------------------------------{{{{
alias fix='rm ~/.zcondump*;exec zsh;'
alias k=kubectl
alias d=docker
alias rtest='bundle exec rspec'
alias gpu=push_upstram_origin
alias mk=make
alias kali='docker run -it --rm kalilinux/kali-linux-docker'
alias ubuntu='docker run -it --rm dockerfile/ubuntu'
alias rsa='railgun status -a -H -o name | xargs -n1 railgun stop'
alias ll='eza -bghHliSa'
alias py='python'
# alias tmux='tmux -2'
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
# }}}}

command -v fzf > /dev/null && source <(fzf --zsh)

export FZF_DEFAULT_OPTS='--extended'
if command -v fd  > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type file'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

export PATH=$PATH:$HOME/swap
export PATH="$HOME/.config/zsh/fp:$PATH"
export CHEATCOLORS=true
export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR="nvim"
export LANG="en_US.UTF-8"


# Added by Krypton
export GPG_TTY=$(tty)
export GOPATH=$HOME/src/github.com
export PATH=$GOPATH/bin:$PATH
export KUBECONFIG=$HOME/.kube/config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# functions -------------------------------------------{{{{
update() {
  sudo softwareupdate -i -a
  brew update
  brew upgrade --all
  brew cask upgrade --all
  brew cleanup
  sudo gem update --system
  sudo gem update
  $EDITOR -c 'PlugClean | PlugUpdate | PlugUpgrade' ~/.config/nvim/init.vim
}

s() {
    branch="$(git branch | fzf-tmux -p --reverse --query="$1" --select-1 --exit-0)"
    if [ ! -z $branch ]
    then
      BRANCH_NAME="$(echo -e "${branch}" | sed -e 's/^[[:space:]]*//')"
      git checkout $BRANCH_NAME
    fi
}
sr() {
    branch="$(git branch -a | fzf-tmux -p --reverse --query="$1" --select-1 --exit-0)"
    if [ ! -z $branch ]
    then
      BRANCH_NAME="$(echo -e "${branch}" | sed -e 's/^[[:space:]]*//')"
      git checkout $BRANCH_NAME
    fi
}

ts() {
    session="$(tmux ls | fzf-tmux -p --reverse --query="$1" --select-1 --exit-0)"
    if [ ! -z $session ]
    then
      SESSION_NAME="$(echo -e "${session}" | sed -e 's/^[[:space:]]*//' | sed -e 's/: .*//')"
      tmux attach -t $SESSION_NAME
    fi
}

git-nvim() {
    git status -s -u | fzf -m --ansi --preview-window "right:33%" --preview "echo {} | cut -d' ' -f 3 | xargs head -$LINES" | cut -d' ' -f 3 | xargs nvim
}

push_upstram_origin() {
    BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
    if [ ! -z $BRANCH_NAME ]
    then
      git push origin -u $BRANCH_NAME
    fi
}

sp() {
    DIRECTORIES=$((cd ~/src/github.com ;ls -dl1 */**) | rg '[^/;]+/[^/;]+$' -o);
    PROJECT_NAME=$(echo $DIRECTORIES | fzf-tmux -p --reverse --query="$1" --select-1 --exit-0)
    if [ ! -z $PROJECT_NAME ]
    then
      cd "$HOME/src/github.com/$PROJECT_NAME"
    fi
}

swap_file_names() {
    first_file=$1
    second_file=$2
    tmp_name="tmp:$first_file+$second_file"
    mv $first_file $tmp_name
    mv $second_file $first_file
    mv $tmp_name $second_file
}

unalias g 2>/dev/null
g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

tn() {
  if [[ $# > 0 ]]; then
    tmux new -s $@
  else
    tmux new -s ${PWD##*/}
  fi
}

rm_orig() {
  find . -name *.orig | xargs rm
}

compdef g=git

docker_clean_all() {
  alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
  alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
  docker kill $(docker ps -q) 2>/dev/null
  docker_clean_ps 2>/dev/null
  docker_clean_images 2>/dev/null
  docker rmi $(docker images -a -q) 2>/dev/null
}

fm() {
  if [[ $# > 0 ]]; then
    CURRENT_DIR=$(pwd) vifm $@
  else
    CURRENT_DIR=$(pwd) vifm .
  fi
}

searchAllGit() {
  {
    find .git/objects/pack/ -name "*.idx" |while read i;do
      git show-index < "$i"|awk '{print $2}'
    done
    find .git/objects/ -type f|grep -v '/pack/'|awk -F'/' '{print $(NF-1)$NF}';
  }|while read o;do
    git cat-file -p $o
  done|grep -E $@
}

docker-shell() {
  shell=${1:-bash}
  container=$(docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Ports}}\t{{.Command}}" | tail -n+2 | fzf | cut -d ' ' -f1)

  if [[ ! -z "$container" ]]; then
    docker exec -it $container $shell
  fi

}

vimwiki () {
  if [[ $# == 0 ]]
  then
    nvim +'VimwikiIndex'
  elif [[ $1 == 'git' ]]
  then
    git -C ~/vimwiki/ ${@:2}
  else
    echo 'Usage: vimwiki [git] [args ...]'
  fi
}

# Bindkeys --------------------------------------------{{{
bindkey -s '^f' "$HOME/src/github.com/abdulwahaab710/dotfiles/bin/.local/tmux-sessionizer^M"
# bindkey -s '^d' "tmux display-popup -E -h 80% -w 80% \"nvim -c VimwikiMakeDiaryNote; exit\"^M"
bindkey -s jj '\e'
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
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
# }}}

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

[[ -f /opt/homebrew/opt/chruby/share/chruby/chruby.sh ]] && ! (type chruby > /dev/null 2>&1) && chruby () { source /opt/homebrew/opt/chruby/share/chruby/chruby.sh }
# [[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 && chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }
[[ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 && chruby () { source /usr/local/opt/chruby/share/chruby/chruby.sh; chruby "$@"; }

type chruby >/dev/null 2>&1 && chruby; chruby 3

[ -f "$HOME/.zshrc.work"  ] && source "$HOME/.zshrc.work"
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
if [ -e /Users/abdulwahaabahmed/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/abdulwahaabahmed/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
### End of Zinit's installer chunk

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

function nvims() {
  items=("default" $(ls ~/.config | rg 'nvim-'))
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

function switch_nvim_config() {
  items=("default" $(ls ~/.config | rg 'nvim-'))
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  export NVIM_APPNAME=$config
}

# bindkey -s ^a "nvims\n"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
