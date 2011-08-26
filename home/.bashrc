case $OSTYPE in
  darwin*)
	source "$HOME/.bash/osx/aliases"
	source "$HOME/.bash/osx/completion"
	source "$HOME/.bash/osx/env"

    # Open man page in textmate
    tman () {
       MANWIDTH=160 MANPAGER='col -bx' man $@ | mate
    }
  ;;
  linux-gnu)
	source "$HOME/.bash/linux/completion"
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

alias la="ls -alG"

# Alias for .tmux-up.sh
alias tup="./.tmux-up.sh"

# Rails aliases
alias cufa="bundle exec rake cucumber:fast"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

