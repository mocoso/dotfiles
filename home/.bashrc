# Custom prompt
# With git branch
source ~/.git-completion.sh


# Lifted from http://railsdog.com/blog/2009/03/07/custom-bash-prompt-for-git-branches/
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

export PS1='\h:\W$(__git_ps1 "[\[\e[0;32m\]%s\[\e[0m\]\[\e[0;33m\]$(parse_git_dirty)\[\e[0m\]]")$ '
# End custom prompt

# Set textmate as default editor
export EDITOR=mate

# Show all branches in gitx
alias gitx="gitx --all"

# Rails aliases
alias cufa="bundle exec rake cucumber:fast"

# Open man page in textmate
tman () {
   MANWIDTH=160 MANPAGER='col -bx' man $@ | mate
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

