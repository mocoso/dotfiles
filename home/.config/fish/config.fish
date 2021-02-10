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

# fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden'
set -gx FZF_DEFAULT_OPTS '--height 40%'

# nix
any-nix-shell fish --info-right | source

# lorri
direnv hook fish | source

# This ugly hack is required because the system oaths end up ahead of nix paths
# when opening a tmux session in a nix shell
function reorder_paths_in_nix_shell
  if string length -q -- $IN_NIX_SHELL
    set -l nix
    set -l core
    for p in $PATH
      if string match -q '*nix*' $p
        set -a nix $p
      else
        set -a core $p
      end
    end
    set -U fish_user_paths $nix $core
  end
end

reorder_paths_in_nix_shell
