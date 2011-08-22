# Custom prompt
# With git branch
source ~/.git-completion.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ ';
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

