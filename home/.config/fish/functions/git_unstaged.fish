function git_unstaged
  if not is_git_repo
    return 1
  end
  not git diff-files --quiet
end
