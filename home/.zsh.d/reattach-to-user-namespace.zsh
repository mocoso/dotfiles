# This function is required to ensure that we can run the
# reattach-user-namespace in a way that won't fail on Linux where it
# does not exist because it is not required.
#
# See https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/issues/8
# for more details
function safe-reattach-to-user-namespace() {
  if [[ "$(uname)" = "Darwin" ]]; then
    reattach-to-user-namespace $@
  else
    exec "$@"
  fi
}

