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
ensure_brew_installed 'ruby-install'
ensure_brew_installed 'fish'

ensure_brew_installed 'reattach-to-user-namespace'
ensure_brew_installed 'tmux'
ensure_brew_installed 'tree'
ensure_brew_installed 'vim'
ensure_brew_installed 'ssh-copy-id'

echo " ---> Check vim has clipboard support"
(vim --version | grep +clipboard > /dev/null) || exit_with_instructions 'Ensure vim is installed with clipboard support'


# terminal
echo " ---> Check 256 colours are available in the terminal"
case "$TERM" in
  *256*) ;;
  *)     exit_with_instructions "Terminal is $TERM - set it to xterm-256color so that 256 colours are available" ;;
esac

# fish
echo " ---> Ensure using fish shell"
(cat /etc/shells | grep /usr/local/bin/fish > /dev/null) || exit_with_instructions 'Add fish to allowed shells with by adding /usr/local/bin/fish to /etc/shells'

if [ "$SHELL" != "/usr/local/bin/fish" ]
then
  chsh -s /usr/local/bin/fish
fi

echo " ---> Ensure submodules are up to date"
git submodule init && git submodule update

echo " ---> Ensure ssh with password is disabled"
(cat /etc/ssh/sshd_config | grep -E '^PasswordAuthentication no' > /dev/null) ||
  (cat /etc/ssh/sshd_config | grep -E '^ChallengeResponseAuthentication no' > /dev/null) ||
  exit_with_instructions "Disable ssh with passwords by

 - Adding (or uncommenting) 'PasswordAuthentication no' from /etc/ssh/sshd_config

 - Adding (or uncommenting) 'ChallengeResponseAuthentication no' from /etc/ssh/sshd_config

 - Restarting sshd with

    sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
    sudo launchctl load /System/Library/LaunchDaemons/ssh.plist"

echo " ---> Delay standby from after 1 hour to after 12 hours"
# see http://www.ewal.net/2012/09/09/slow-wake-for-macbook-pro-retina/ for more
# details
sudo pmset -a standbydelay 43200

echo " ---> Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

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
defaults write NSGlobalDomain KeyRepeat -int 5
defaults write NSGlobalDomain InitialKeyRepeat -int 10

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

echo " ---> Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle -string "Clmv"

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

echo " ---> Disable smart quotes and dashes"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo " ---> Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

echo " ---> Symlink dotfiles"
make > /dev/null

check_app_installed "Dropbox" "open https://www.dropbox.com; exit_with_instructions 'Install Dropbox from https://www.dropbox.com'"

echo " ---> Set up completions for fish"
fish -c fish_update_completions

printf "\nReady to go\n"
