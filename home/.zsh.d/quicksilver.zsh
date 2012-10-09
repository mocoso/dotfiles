qstext() {
  if (( ${+OSX} ))
  then
    eval "osascript -e 'tell application \"Quicksilver\" to show large type \"$@\"'"
  else
    echo "Only supported on OSX"
  fi
}

