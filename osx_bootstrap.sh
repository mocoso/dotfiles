#!/usr/bin/env bash

function exit_with_instructions {
  echo ""
  echo "$1" >&2
  echo ""
  exit 1
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

function ensure_ssh_option_is_off {
  (cat /etc/ssh/sshd_config | grep -E "^$1 no" > /dev/null) ||
    (
      (sudo sed -i .bak "/^$1 yes/d" /etc/ssh/sshd_config) &&
      echo "$1 no" | sudo tee -a /etc/ssh/sshd_config &&
      sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist &&
      sudo launchctl load /System/Library/LaunchDaemons/ssh.plist
    )
}

echo " ---> Ensure ssh with password is disabled"
ensure_ssh_option_is_off 'PasswordAuthentication'
ensure_ssh_option_is_off 'ChallengeResponseAuthentication'


echo " ---> Desktop & Screen Saver settings"

echo " ---> Screen Saver: Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0


echo " ---> Dock settings"

echo " ---> Dock: Automatically hide and show"
defaults write com.apple.dock autohide -bool true

echo " ---> Dock: Move to left of screen"
defaults write com.apple.dock orientation -string left


echo " ---> Mission Control settings"

echo " ---> Mission Control: Speed up animations"
defaults write com.apple.dock expose-animation-duration -float 0.1


echo " ---> Software Update settings"

echo " ---> Software Update: Check for updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1


echo " ---> Printer settings"

echo " ---> Printer: Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo " ---> Printer: Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true


echo " ---> Keyboard settings"

echo " ---> Keyboard: Set a blazingly fast repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 5
defaults write NSGlobalDomain InitialKeyRepeat -int 10


echo " ---> Trackpad settings"

echo " ---> Trackpad: Setting speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2


echo " ---> Mouse settings"

echo " ---> Mouse: Setting speed to a reasonable number"
defaults write -g com.apple.mouse.scaling 2.5


echo " ---> Display settings"

echo " ---> Display: Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2


echo " ---> Energy Saver settings"

echo " ---> Energy Saver: Hide percentage in menu bar"
defaults write com.apple.menuextra.battery ShowPercent -string "NO"

echo " ---> Energy Saver: show remaining battery time (on pre-10.8) in menu bar"
defaults write com.apple.menuextra.battery ShowTime -string "YES"


echo " ---> Time Machine settings"

echo " ---> Time macine: Prevent from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


echo " ---> Menu Bar settings"

echo " ---> Menu Bar: disable transparency"
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false



echo " ---> Finder settings"

echo " ---> Finder: Show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo " ---> Finder: Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo " ---> Finder: Show path bar"
defaults write com.apple.finder ShowPathBar -bool true

echo " ---> Finder: Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo " ---> Finder: Use column view in windows by default"
defaults write com.apple.finder FXPreferredViewStyle -string "Clmv"

echo " ---> Finder: Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo " ---> Finder: Remove the spring loading delay for directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0


echo " ---> Miscelleneous settings"

echo " ---> Disable the sound effects on boot"
(nvram -d name SystemAudioVolume &> /dev/null) && sudo nvram -d SystemAudioVolume

echo " ---> Disable opening and closing window animations"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo " ---> Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo " ---> Disable dashboard"
defaults write com.apple.dashboard mcx-disabled -boolean YES

echo " ---> Disable smart quotes and dashes"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


check_app_installed "Dropbox" "open https://www.dropbox.com; exit_with_instructions 'Install Dropbox from https://www.dropbox.com'"


printf "\nReady to go\n"
