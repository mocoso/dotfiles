export GIT_EDITOR="vim -f"

# Aliases
alias gst='git status'
compdef _git gst=git-status
alias gup='git fetch && git rebase'
compdef _git gup=git-fetch
alias gpu='git push'
compdef _git gpu=git-push
alias gc='git commit -v'
compdef _git gc=git-commit
alias gco='git checkout'
compdef _git gco=git-checkout
alias gcm='git checkout master'
alias gbr='git branch'
compdef _git gbr=git-branch
alias gcount='git shortlog -sn'
compdef gcount=git
alias gcp='git cherry-pick'
compdef _git gcp=git-cherry-pick
alias glg='git log --stat --max-count=10'
compdef _git glg=git-log
alias ggg='git log --oneline --abbrev-commit --all --graph --decorate'
compdef _git ggg=git-log
alias grb='git rebase'
compdef _git grb=git-rebase
alias gss='git status -s'
compdef _git gss=git-status
alias gad='git add'
compdef _git gad=git-add
alias gmg='git merge'
compdef _git gmg=git-merge
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
