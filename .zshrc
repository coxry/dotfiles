# Setup Oh My ZSH
ZSH=$HOME/.oh-my-zsh
plugins=(bundler brew npm pip gem git docker docker-compose yarn tmux)
ZSH_THEME=""

autoload -U promptinit; promptinit
prompt pure

DISABLE_AUTO_UPDATE='true'
source $ZSH/oh-my-zsh.sh

# Source our split out dotfiles
[ -f ~/.aws_secrets ] && source ~/.aws_secrets
[ -f ~/.alias ] && source ~/.alias
[ -f ~/.fzf_functions ] && source ~/.fzf_functions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.custom ] && source ~/.custom

export GREP_OPTIONS='--color=auto'
export PAGER=less
export PATH=$PATH:$HOME/.bin:/usr/local/bin
export MANPAGER="col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -"
export FZF_DEFAULT_COMMAND='rg --files --follow --glob "!.git/*"'
export EDITOR=nvim
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
eval "$(hub alias -s)"
