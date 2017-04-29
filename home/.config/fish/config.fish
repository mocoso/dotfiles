set -g fish_color_cwd white
set -g fish_color_uneditable_cwd white

# chruby
source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

# git
set -U GIT_EDITOR "vim -f"

alias gst="git status -sb"
alias gup="git fetch ;and git rebase"
alias gpu="git push"
alias gc="git commit -v"
alias gcm="git checkout master"
alias gco="git checkout"
alias gbr="git branch"
alias gcount="git shortlog -sn"
alias gcp="git cherry-pick"
alias glg="git log --stat --max-count=10"
alias gg="git log --oneline --abbrev-commit --graph --decorate"
alias ggg="git log --oneline --abbrev-commit --all --graph --decorate"
alias grb="git rebase"
alias gss="git status -s"
alias gad="git add"
alias gmg="git merge"
alias gd="git diff"
alias grh="git reset HEAD"
alias grhh="git reset HEAD --hard"

# homebrew
# prioritise binaries installed by homebrew
# TODO: only apply for OSX
set PATH /usr/local/bin /usr/local/sbin $PATH

# ls
alias l="ls -alG"
