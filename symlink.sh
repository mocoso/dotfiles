#!/usr/bin/env bash

# Symlinks dotfiles

# Mostly borrowed from homeshick (https://github.com/andsens/homeshick)

# Define some colors
txtdef="\e[0m"    # Revert to default
bldred="\e[1;31m" # Red - error
bldgrn="\e[1;32m" # Green - success
bldblu="\e[1;34m" # Blue - no action/ignored
bldcyn="\e[1;36m" # Cyan - pending action

dotfilehome="$PWD/home"
direrrors=''

SKIP=false
FORCE=false

usage()
{
cat << EOF
usage: $0 options

Symlink these dotfiles into your home directory

OPTIONS:
   -h      Show this message
   -f      Force overwrites of files
   -s      Skip conflicts
EOF
}

while getopts “hfs” OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    f)
      FORCE=true
      ;;
    s)
      SKIP=true
      ;;
  esac
done

function status {
  printf "$1%13s$txtdef %s\n" "$2" "$3"
}

pending_status=''
pending_message=''
function pending {
  pending_status="$1"
  pending_message="$2"
  printf "$bldcyn%13s$txtdef %s" "$pending_status" "$pending_message"
}

function success {
  if [ "$1" ]; then
    pending_status=$1
  fi
  printf "\r$bldgrn%13s$txtdef %s\n" "$pending_status" "$pending_message"
}

# Symlink the files
for filepath in `find $dotfilehome -maxdepth 1 -name ".*"`; do
  file=`basename $filepath`
  if [[ -e $HOME/$file && `readlink "$HOME/$file"` == "$dotfilehome/$file" ]]; then
    status $bldblu 'identical' $file
    continue
  fi

  if [ -e $HOME/$file ] || [ -L $HOME/$file ]; then
    if $SKIP; then
      status $bldblu 'exists' $file
      continue
    fi
    if ! $FORCE; then
      status $bldred 'conflict' "$file exists"
      read -p "Overwrite $file? [yN]" overwrite
      if [[ ! $overwrite =~ [Yy] ]]; then
        continue
      fi
    fi
    pending 'overwrite' $file
    rm -rf "$HOME/$file"
  else
    pending 'symlink' $file
  fi

  ln -s $dotfilehome/$file $HOME/$file
  success
done

if [[ -n "$direrrors" && $FORCE = false ]]; then
  printf "\nThe following directories already exist and will only\n" >&2
  printf "be overwritten, if you delete or move them manually:\n" >&2
  printf "$direrrors\n" >&2
fi
