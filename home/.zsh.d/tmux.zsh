# This function will:
#
# If the current direction has a tmux set up script (./tmux-up.zsh) then it
# will name the current tab and then check to see if there is session named
# after the current directory, 'project' say.
#
# If yes, it'll attach it and exit
#
# If no, it'll create a new sessin and run the config script before attaching to
# it
function tmux_session_with_set_up() {
  project_script=".tmux-up.zsh"

  if test -f $project_script; then
    project_name=$PWD:t

    # Name the tab
    # echo -ne "\e]2;${project_name}\a"
    echo -n -e "\033]0;{$project_name}\007"

    if ! tmux has-session -t $name ; then
      tmux new-session -d -s $project_name
      `./$project_script`
    fi

    tmux attach -t $project_name 
  else
    tmux
  fi
}

alias tmux='tmux_session_with_set_up'
