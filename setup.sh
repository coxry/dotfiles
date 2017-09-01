ln .vimrc ~/.config/init.vim
ln .gitconfig ~/
ln .inputrc ~/
ln .psqlrc ~/
ln .tmux.conf ~/
ln .zshrc ~/
ln .custom.zsh-theme ~/.oh-my-zsh/themes/custom.zsh-theme
mkdir ~/.bin
# Install homebrew before this
brew install ansiweather
ln ./.bin/tmux-weather ~/.bin/tmux-weather
ln ./.bin/truecolor ~/.bin/truecolor

defaults write com.apple.screencapture location ~/Downloads
killall SystemUIServer
