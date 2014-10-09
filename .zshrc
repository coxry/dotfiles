ZSH=$HOME/.oh-my-zsh

ZSH_THEME="custom"

source $ZSH/oh-my-zsh.sh

# export PATH=~/bin:/Users/raymondcox/.rvm/gems/ruby-2.0.0-p0/bin:/Users/raymondcox/.rvm/gems/ruby-2.0.0-p0@global/bin:/Users/raymondcox/.rvm/rubies/ruby-2.0.0-p0/bin:/Users/raymondcox/.rvm/bin:/usr/local/bin:usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:$PATH

plugins=(git bundler brew gem)
export GREP_OPTIONS='--color=auto'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

export EDITOR="vim"
alias g=git
alias v=nvim
alias ls="ls -G"

# https://www.youtube.com/watch?v=SMWi7CLoZ2Q
alias nom="rm -rf node_modules && npm cache clear && npm i"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
