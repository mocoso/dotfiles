set -x GPG_TTY (tty)

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
abbr gc "git commit -v"
abbr gca "git commit -v --amend"
abbr gsw "git switch"
abbr gbr "git branch"
abbr gcp "git cherry-pick"
abbr gg "git log --oneline --abbrev-commit --graph --decorate"
abbr ggg "git log --oneline --abbrev-commit --all --graph --decorate"
abbr grb "git rebase"
abbr ga "git add"
abbr gap "git add --patch"
abbr gd "git diff"
abbr grh "git reset HEAD"
abbr grhh "git reset HEAD --hard"

# ls
alias l="ls -alG"
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

# tmux
function sanitise_for_tmux_session_name
  string replace -a '.' '' $argv
end

function attach_to_or_create_new_tmux_session_for_current_directory
  set --local session_name (sanitise_for_tmux_session_name $PWD)
  if tmux has-session -t $session_name
    tmux attach-session -t $session_name
  else
    tmux new-session -s $session_name
  end
end

alias tmd attach_to_or_create_new_tmux_session_for_current_directory

# brew
function clean-upgrade
  brew uninstall --ignore-dependencies $argv; and brew install $argv
end

# fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden'
set -gx FZF_DEFAULT_OPTS '--height 40%'

# gcloud
set -g -x "CLOUDSDK_PYTHON" "/usr/local/opt/python@3.8/libexec/bin/python"
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
