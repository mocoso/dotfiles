set -g fish_color_cwd white
set -g fish_color_uneditable_cwd white

# bundler
abbr be "bundle exec"

# fry
source /usr/local/opt/fry/share/fry/fry.fish

# git
alias gst="git status -sb"
alias gup="git fetch ;and git rebase"
alias gpu="git push"
alias gc="git commit -v"
abbr gcm "git checkout master"
abbr gco "git checkout"
abbr gbr "git branch"
alias gcount="git shortlog -sn"
abbr gcp "git cherry-pick"
alias glg="git log --stat --max-count=10"
alias gg="git log --oneline --abbrev-commit --graph --decorate"
alias ggg="git log --oneline --abbrev-commit --all --graph --decorate"
abbr grb "git rebase"
alias gss="git status -s"
abbr gad "git add"
abbr gmg "git merge"
abbr gd "git diff"
abbr grh "git reset HEAD"
abbr grhh "git reset HEAD --hard"

# ls
alias l="ls -alG"
