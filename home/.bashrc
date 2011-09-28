source "$HOME/.bash.d/aliases"

case $OSTYPE in
  darwin*)
    source "$HOME/.bash.d/osx/aliases"
    source "$HOME/.bash.d/osx/aws"
    source "$HOME/.bash.d/osx/completion"
    source "$HOME/.bash.d/osx/env"

    # Open man page in textmate
    tman () {
       MANWIDTH=160 MANPAGER='col -bx' man $@ | mate
    }
  ;;
  linux-gnu)
    source "$HOME/.bash.d/linux/completion"
    source "$HOME/.bash.d/linux/vagrant"
  ;;
esac

# Custom prompt
# With git branch
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  source /usr/local/etc/bash_completion.d/git-completion.bash
fi

# Lifted from http://railsdog.com/blog/2009/03/07/custom-bash-prompt-for-git-branches/
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] \
	&& echo "*"
}

export PS1='\h:\W$(__git_ps1 "[\[\e[0;32m\]%s\[\e[0m\]\[\e[0;33m\]$(parse_git_dirty)\[\e[0m\]]")$ '
# End custom prompt

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

