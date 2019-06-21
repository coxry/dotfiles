ZSH=$HOME/.oh-my-zsh
plugins=(bundler brew gem git)
ZSH_THEME='custom'
DISABLE_AUTO_UPDATE='true'
source $ZSH/oh-my-zsh.sh
export GREP_OPTIONS='--color=auto'

export PAGER=less

alias git=hub
alias es='ember s'
alias rs="rails s"
alias v=nvim
alias vim=nvim
alias ls='ls -G'
alias sim="xcrun instruments -w 'iPhone 6s (9.0)'"
alias nom='rm -rf node_modules && npm cache clear && npm i'
alias nombom='rm -rf node_modules && rm -rf bower_components && npm install && bower install'
alias tmux="env TERM=xterm-256color tmux"
alias todo='$EDITOR ~/.todo'
alias flushdns='dscacheutil -flushcache; sudo killall -HUP mDNSResponder; say flushed'
alias git-cleanup-remote="git branch -r --merged | grep -v master | grep origin | sed 's/origin\///' | xargs -n 1 git push --delete origin"
function t() {
  tmux attach-session -t$1
}
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
  export VISUAL='nvim'
fi

source ~/.aws_secrets
source ~/.alias

ulimit -n 2560

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:$HOME/.bin:$HOME/local/bin:/usr/local/bin
export MANPAGER="col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -"
export NVM_DIR="$HOME/.nvm"

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/raymondcox/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/raymondcox/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/raymondcox/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/raymondcox/google-cloud-sdk/completion.zsh.inc'; fi
