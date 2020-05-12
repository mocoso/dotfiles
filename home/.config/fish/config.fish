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
abbr gup "git fetch && git rebase origin/master"
abbr gpu "git push"
abbr gc "git commit -v"
abbr gca "git commit -v --amend"
abbr gsm "git switch master"
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
  string replace '.' '' $argv
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

# docker
function docker-start
  echo "-- Starting Docker.app, if necessary..."

  open -g -a Docker.app || exit

  # Wait for the server to start up, if applicable
  printf 'Waiting for Docker to finish starting up...'

  while ! docker system info &>/dev/null
    printf '.'
    sleep 1
  end
  printf '\n-- Docker is ready.'
end


function docker-stop
  echo "-- Quitting Docker.app, if running..."

  osascript -e 'tell application "Docker"
    if it is running then quit it
  end tell'

  echo "-- Docker is stopped."
  echo "Caveat: Restarting it too quickly can cause errors."
end
