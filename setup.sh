ln .gitconfig ~/
ln .inputrc ~/
ln .psqlrc ~/
ln .tmux.conf ~/
ln .zshrc ~/
ln .custom.zsh-theme ~/.oh-my-zsh/themes/custom.zsh-theme
ln .alias ~/.alias
mkdir ~/.bin
ln .bin/notes ~/.bin
# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install homebrew before this
brew install reattach-to-user-namespace

# Neovim
brew install neovim
ln init.vim ~/.config/nvim/init.vim
mkdir -p ~/.nvim/backups
mkdir -p ~/.nvim/swaps
mkdir -p ~/.nvim/undo

