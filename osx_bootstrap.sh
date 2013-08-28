#!/usr/bin/env bash

function check_installed {
  echo " ---> Check $1 installed"
  command -v $1 >/dev/null 2>&1 || { echo " ---> Missing"; eval $2; } || { exit 1; }
}

function exit_with_instructions {
  echo ""
  echo "$1" >&2
  echo ""
  exit 1
}

function ensure_brew_installed {
  echo " ---> Check $1 brew installed"
  brew list | grep $1 > /dev/null || brew install $1
}

function check_app_installed {
  echo " ---> Check $1 app installed"
  if [[ ! -d "/Applications/$1.app" ]]
  then
    echo " ---> Missing"
    eval $2
    echo 1
  fi
}

check_installed 'brew' 'exit_with_instructions "Install homebrew from http://mxcl.github.com/homebrew/"'
brew doctor || { exit 1; }

ensure_brew_installed 'ctags'
ensure_brew_installed 'git'
ensure_brew_installed 'rbenv'
ensure_brew_installed 'rbenv-gemset'
ensure_brew_installed 'ruby-build'
ensure_brew_installed 'reattach-to-user-namespace'
ensure_brew_installed 'tmux'
ensure_brew_installed 'tree'
ensure_brew_installed 'mercurial' # for vim
ensure_brew_installed 'vim'

check_app_installed "Dropbox" "open https://www.dropbox.com; exit_with_instructions 'Install Dropbox from https://www.dropbox.com'"
check_app_installed "GitX" "open http://gitx.frim.nl; exit_with_instructions 'Install GitX from http://gitx.frim.nl'"
check_app_installed "iTerm" "open http://www.iterm2.com/#/section/home; exit_with_instructions 'Install iTerm from http://www.iterm2.com/#/section/home'"
check_app_installed "Sidestep" "open http://chetansurpur.com/projects/sidestep/; exit_with_instructions 'Install Sidestep from http://chetansurpur.com/projects/sidestep/'"

# terminal
echo " ---> Check 256 colours are available in the terminal"
case "$TERM" in
  *256*) ;;
  *)     exit_with_instructions "Terminal is $TERM - set it to xterm-256color so that 256 colours are available" ;;
esac

# zsh
ensure_brew_installed 'zsh'

echo " ---> Ensure using brew installed zsh"
(cat /etc/shells | grep /usr/local/bin/zsh > /dev/null) || exit_with_instructions 'Add zsh to allowed shells with by adding /usr/local/bin/zsh to /etc/shells'

if [ "$SHELL" != "/usr/local/bin/zsh" ]
then
  chsh -s /usr/local/bin/zsh
fi

echo " ---> Ensure submodules are up to date"
git submodule init && git submodule update

echo " ---> Ensure ssh with password is disabled"
(cat /etc/sshd_config | grep -E '^PasswordAuthentication no' > /dev/null) ||
  (cat /etc/sshd_config | grep -E '^ChallengeResponseAuthentication no' > /dev/null) ||
  exit_with_instructions "Disable ssh with passwords by

 - Adding (or uncommenting) 'PasswordAuthentication no' from /etc/sshd_config

 - Adding (or uncommenting) 'ChallengeResponseAuthentication no' from /etc/sshd_config

 - Restarting sshd with

    sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
    sudo launchctl load /System/Library/LaunchDaemons/ssh.plist"

echo " ---> Disable path_helper because it reorders the path when it is run"
# So far disabling this has not caused any problems and having it enabled
# causes problems with the path for vim terminal running under tmux
sudo chmod ugo-x /usr/libexec/path_helper

echo " ---> Delay standby from after 1 hour to after 12 hours"
# see http://www.ewal.net/2012/09/09/slow-wake-for-macbook-pro-retina/ for more
# details
sudo pmset -a standbydelay 43200

echo " ---> Menu bar: disable transparency"
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

echo " ---> Menu bar: show remaining battery time (on pre-10.8); hide percentage"
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

echo " ---> Disable opening and closing window animations"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo " ---> Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo " ---> Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo " ---> Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo " ---> Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo " ---> Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0

echo " ---> Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo " ---> Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo " ---> Finder: show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo " ---> Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo " ---> Finder: show path bar"
defaults write com.apple.finder ShowPathBar -bool true

echo " ---> Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo " ---> Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo " ---> Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo " ---> Remove the spring loading delay for directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0

echo " ---> Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo " ---> Enable access for assistive devices"
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled

echo " ---> Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo " ---> Move Dock to left of screen"
defaults write com.apple.dock orientation -string left

echo " ---> Speed up Mission Control animations"
defaults write com.apple.dock expose-animation-duration -float 0.1

echo " ---> Disable dashboard"
defaults write com.apple.dashboard mcx-disabled -boolean YES

echo " ---> Symlink dotfiles"
./symlink.sh > /dev/null

printf "\nReady to go\n"
