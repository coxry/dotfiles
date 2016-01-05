ZSH=$HOME/.oh-my-zsh
plugins=(bundler brew gem git)

KEYTIMEOUT=1

export ANDROID_HOME='/Users/rj/android-sdk-macosx'

ZSH_THEME='custom'
DISABLE_AUTO_UPDATE='true'
source $ZSH/oh-my-zsh.sh

# export PATH=~/bin:/Users/raymondcox/.rvm/gems/ruby-2.0.0-p0/bin:/Users/raymondcox/.rvm/gems/ruby-2.0.0-p0@global/bin:/Users/raymondcox/.rvm/rubies/ruby-2.0.0-p0/bin:/Users/raymondcox/.rvm/bin:/usr/local/bin:usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:$PATH
export PATH=~/android-sdk-macosx/tools:$PATH

# plugins=(bundler brew gem battery httpie git hub)
# plugins=(bundler brew gem battery httpie git)
alias git=hub
alias es='ember s'
alias fsp='DISABLE_SPRING=1 RUN_ALL_TESTS=1 bundle exec parallel_rspec -n 6 spec'
alias fspf='DISABLE_SPRING=1 RUN_ALL_TESTS=1 find spec -name '\''*_spec.rb'\'' -type f -print | grep -v api | tr '\''\n'\'' '\'' '\'' | xargs bundle exec parallel_rspec -n 6'


export GREP_OPTIONS='--color=auto'

export EDITOR='nvim'
alias v=nvim
alias vim=nvim
alias ls='ls -G'
alias sim="xcrun instruments -w 'iPhone 6s (9.0)'"

# https://www.youtube.com/watch?v=SMWi7CLoZ2Q
alias nom='rm -rf node_modules && npm cache clear && npm i'
alias nombom='rm -rf node_modules && rm -rf bower_components && npm install && bower install'

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export NVM_DIR='/Users/rj/.nvm'
[ -s '$NVM_DIR/nvm.sh' ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

MAGICK_HOME=/usr/local/Cellar/ImageMagick/6.9.0-3
DYLD_LIBRARY_PATH=/usr/local/Cellar/ImageMagick/6.9.0-3/lib

source ~/.aws_secrets
ulimit -n 2560

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/go/bin
export PATH=$PATH:$HOME/.bin
export MANPAGER="col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -"
alias tmux='TERM=screen-256color-bce tmux'
alias todo='$EDITOR ~/.todo'
alias flushdns='dscacheutil -flushcache; sudo killall -HUP mDNSResponder; say flushed'

# # [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
