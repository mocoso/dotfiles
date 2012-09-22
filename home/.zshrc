# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.zsh.d

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# source every .zsh file in this rep
for config_file ($ZSH/*.zsh) source $config_file

# load every completion after autocomplete loads
# for config_file ($ZSH/**/completion.zsh) source $config_file
