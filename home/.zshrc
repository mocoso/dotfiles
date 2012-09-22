# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.zsh.d

# your project folder that we can `c [tab]` to
export PROJECTS=~/Projects

# source every .zsh file in this rep
for config_file ($ZSH/*.zsh) source $config_file

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
# for config_file ($ZSH/**/completion.zsh) source $config_file

source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
