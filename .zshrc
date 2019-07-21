# Setup Oh My ZSH
ZSH=$HOME/.oh-my-zsh
plugins=(bundler gem git)
ZSH_THEME='custom'
DISABLE_AUTO_UPDATE='true'
source $ZSH/oh-my-zsh.sh

# Source our split out dotfiles
[ -f ~/.aws_secrets ] && source ~/.aws_secrets
[ -f ~/.alias ] && source ~/.alias
[ -f ~/.fzf_functions ] && source ~/.fzf_functions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.custom ] && source ~/.custom

function t() {
  tmux attach-session -t$1
}

ulimit -n 2560

export GREP_OPTIONS='--color=auto'
export PAGER=less
export PATH=$PATH:$HOME/.bin:$HOME/local/bin:/usr/local/bin
export MANPAGER="col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -"
export FZF_DEFAULT_COMMAND='rg --files --follow --glob "!.git/*"'
export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
