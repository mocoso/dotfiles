set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 0

set -g __fish_git_prompt_color_branch yellow
set -g __fish_git_prompt_showupstream "none"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "+"
set -g __fish_git_prompt_char_untrackedfiles ""
set -g __fish_git_prompt_char_conflictedstate "×"
set -g __fish_git_prompt_char_cleanstate ""

set -g __fish_git_prompt_color_dirtystate yellow -o
set -g __fish_git_prompt_color_stagedstate green -o
set -g __fish_git_prompt_color_invalidstate red -o
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green

function git_initials --description 'The initials for who I am currently pairing with'
  set -lx initials (git mob-print --initials)
  if test -n "$initials"
    printf ' [%s]' $initials
  end
end

function fish_prompt --description 'Write out the prompt'
  printf '%s%s%s:' (set_color purple) (hostname|cut -d . -f 1) (set_color normal)

  # Write the process working directory
  if test -w "."
    printf '%s%s' (set_color -o $fish_color_cwd) (prompt_pwd)
  else
    printf '%s%s' (set_color -o $fish_color_uneditable_cwd) (prompt_pwd)
  end

  printf '%s' (__fish_git_prompt)

  printf '%s%s' (set_color cyan -o) (git_initials)

  printf '%s $ %s' (set_color white -o) (set_color normal)
end
