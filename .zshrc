ZSH=$HOME/.oh-my-zsh

ZSH_THEME="custom"

plugins=(git, terminalapp)

source $ZSH/oh-my-zsh.sh

# export PATH=~/bin:/Users/raymondcox/.rvm/gems/ruby-2.0.0-p0/bin:/Users/raymondcox/.rvm/gems/ruby-2.0.0-p0@global/bin:/Users/raymondcox/.rvm/rubies/ruby-2.0.0-p0/bin:/Users/raymondcox/.rvm/bin:/usr/local/bin:usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:$PATH

plugins=(git bundler brew gem)
export GREP_OPTIONS='--color=auto'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export EDITOR="vim"
alias g=git
