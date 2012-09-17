function fish_prompt --description 'Write out the prompt'
  printf '%s%s%s:' (set_color cyan) (hostname|cut -d . -f 1) (set_color normal)

  # Write the process working directory
  if test -w "."
    printf '%s%s' (set_color -o $fish_color_cwd) (prompt_pwd)
  else
    printf '%s%s' (set_color -o $fish_color_uneditable_cwd) (prompt_pwd)
  end

  if is_git_repo
    printf '%s±%s%s' (set_color red) (set_color white) (__git_ps1)
  end

  if git_dirty
    printf '%s!' (set_color yellow)
  end

  printf '%s $%s' (set_color -o $fish_color_cwd) (set_color normal)

  printf '%s ' (set_color normal)
end
