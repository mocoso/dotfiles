function git_staged
  if not is_git_repo
    return 1
  end
  not git diff-index --quiet --cached HEAD
end
