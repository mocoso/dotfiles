# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.zsh.d

# Use the following construct for platform specific sections
#
#    if (( ${+OSX} ))
#    then
#      ...do that thing...
#    fi

case $OSTYPE in
  darwin*)
    export OSX=true
  ;;
  linux-gnu*)
    export LINUX=true
  ;;
esac


# source every .zsh file in this rep
source $ZSH/aws.zsh
source $ZSH/completion.zsh
source $ZSH/git.zsh
source $ZSH/gitx.zsh
source $ZSH/history.zsh
source $ZSH/hitch.zsh
source $ZSH/homebrew.zsh
source $ZSH/ls.zsh
source $ZSH/prompt.zsh
source $ZSH/quicksilver.zsh
source $ZSH/rbenv.zsh
source $ZSH/spectrum.zsh
source $ZSH/time.zsh
source $ZSH/tmux.zsh
source $ZSH/vim.zsh
source $ZSH/zeus.zsh
source $ZSH/zsh.zsh
source $ZSH/bundler.zsh # Load bundler last so it sets the path after homebrew and rbenv

# load every completion after autocomplete loads
# for config_file ($ZSH/**/completion.zsh) source $config_file

source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/zsh-history-substring-search/zsh-history-substring-search.zsh

# Entering the name of a directory (if it's not a command) will automatically
# cd to that directory.
setopt autocd
