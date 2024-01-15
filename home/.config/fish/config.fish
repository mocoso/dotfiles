set -x PATH /opt/homebrew/bin:/opt/homebrew/sbin $PATH

set -x GPG_TTY (tty)

set -g fish_color_cwd white
set -g fish_color_uneditable_cwd white

set -gx EDITOR vim

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
abbr gsf "git branch | fzf | sed 's/*//' | xargs git checkout"
abbr gco "git checkout"
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
function l
  if which -s exa
    exa -al --git
  else
    ls -alG
  end
end

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

# direnv
direnv hook fish | source

# favicon & imagemagick
function png2ico
  convert $argv -define icon:auto-resize=64,48,32,16 favicon.ico

  echo "Open favicon.ico with GIMP, and export to compress this to a reasonable size"
end

function chrome-profile
  set app "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  exec $app --enable-udd-profiles --user-data-dir="/Users/$USER/Library/Application Support/Google/Chrome/$argv"
end

function remarkable-auto-sleep-long
  ssh remarkable sed -i 's/IdleSuspendDelay=.*$/IdleSuspendDelay=24000000/' /etc/remarkable.conf
end

function remarkable-auto-sleep-off
  ssh remarkable sed -i 's/IdleSuspendDelay=.*$/IdleSuspendDelay=0/' /etc/remarkable.conf
end
