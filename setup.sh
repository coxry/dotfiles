ln .gitconfig ~/
ln .inputrc ~/
ln .psqlrc ~/
ln .tmux.conf ~/
ln .zshrc ~/
ln .custom.zsh-theme ~/.oh-my-zsh/themes/custom.zsh-theme
mkdir ~/.bin

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install homebrew before this
brew install reattach-to-user-namespace
brew install neovim

ln .vimrc ~/.config/nvim/init.vim
