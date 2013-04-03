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

source $ZSH/aws.zsh
source $ZSH/completion.zsh
source $ZSH/git.zsh
source $ZSH/gitx.zsh
source $ZSH/go.zsh
source $ZSH/history.zsh
source $ZSH/hitch.zsh
source $ZSH/homebrew.zsh
source $ZSH/ls.zsh
source $ZSH/python.zsh
source $ZSH/quicksilver.zsh
source $ZSH/rbenv.zsh
source $ZSH/time.zsh
source $ZSH/vim.zsh
source $ZSH/zeus.zsh
source $ZSH/bundler.zsh # Load bundler last so it sets the path after homebrew and rbenv

