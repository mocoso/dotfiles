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
for config_file ($ZSH/*.zsh) source $config_file

# load every completion after autocomplete loads
# for config_file ($ZSH/**/completion.zsh) source $config_file

source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/zsh-history-substring-search/zsh-history-substring-search.zsh

# Entering the name of a directory (if it's not a command) will automatically
# cd to that directory.
setopt autocd
