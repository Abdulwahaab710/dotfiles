source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

### Added by Zplugin's installer
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk
zplugin load zdharma/fast-syntax-highlighting

##########################
# Aliases
##########################
alias add='git add'
alias commit='git commit'
alias k='kubectl'
alias ll='exa -bghHliSFa'
alias pull='git pull'
alias push='git push'
alias g='git'
alias status='git status'
alias stash='git stash'
alias pop='git stash pop'
alias checkout='git checkout'
alias prebase='git pull rebase'
# alias git-nvim='git status -s -u | fzf -m --ansi --preview-window "right:33%" --preview "echo {} | cut -d' ' -f 3 | xargs head -$LINES" | cut -d' ' -f 3 | xargs vim'
alias rtest='bundle exec rspec'
alias s='fast_git_branch_select'
alias ts='fast_tmux_session_select'

###########################
# Autocomplete
###########################
source <(kubectl completion zsh)

export CLICOLOR=1
export is_nvim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?)(diff)?$"'
[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
prompt powerlevel9k

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GREP_COLOR=31

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/Downloads/google-cloud-sdk/path.zsh.inc" ]; then source "${HOME}/Downloads/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then source "${HOME}/Downloads/google-cloud-sdk/completion.zsh.inc"; fi

###########################
# Functions
###########################
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
