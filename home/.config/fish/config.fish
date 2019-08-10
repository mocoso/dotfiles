set -x PATH /usr/local/sbin $PATH

set -g fish_color_cwd white
set -g fish_color_uneditable_cwd white

# bundler
abbr be "bundle exec"

# docker
abbr dkps "docker ps"
abbr dkprune "docker system prune -af"
abbr dks "docker-compose stop"
abbr dkb "docker-compose build"
abbr dku "docker-compose up"
abbr dkud "docker-compose up -d"
abbr dkl "docker-compose logs"
abbr dke "docker-compose exec"
abbr dkr "docker-compose run"

# git
abbr gst "git status -sb"
abbr gup "git fetch ;and git rebase"
abbr gpu "git push"
abbr gc "git commit -v"
abbr gcm "git checkout master"
abbr gco "git checkout"
abbr gbr "git branch"
abbr gcount "git shortlog -sn"
abbr gcp "git cherry-pick"
abbr glg "git log --stat --max-count=10"
abbr gg "git log --oneline --abbrev-commit --graph --decorate"
abbr ggg "git log --oneline --abbrev-commit --all --graph --decorate"
abbr grb "git rebase"
abbr gss "git status -s"
abbr gad "git add"
abbr gmg "git merge"
abbr gd "git diff"
abbr grh "git reset HEAD"
abbr grhh "git reset HEAD --hard"

# ls
alias l="ls -alG"
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

