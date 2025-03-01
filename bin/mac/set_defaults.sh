#! /bin/bash

sudo -v

# scroll bars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# dock size
defaults write com.apple.dock tilesize -int 52

# drop all default dock apps
defaults write com.apple.dock persistent-apps -array

# dock genie
defaults write com.apple.dock autohide -bool true

# hide recent apps in dock
defaults write com.apple.dock show-recents -bool false

# key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# tracking speed
defaults write -g com.apple.trackpad.scaling 5.0
defaults write -g com.apple.mouse.scaling 3

# trackpad firmness (?)
defaults write -g com.apple.trackpad.forceClick 1

# sleep settings
sudo pmset -a displaysleep 15
sudo pmset -a disksleep 60

# show full paths
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# no remote DS_STORE files
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# no trash warning
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# unhide folders
sudo chflags nohidden /Volumes ~/Library

# TODO: spotlight not importing prefs correctly as of 14.5

# defaults write com.apple.spotlight orderedItems -array \
# '{"enabled" = 1;"name" = "APPLICATIONS";}'
# 	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
# 	'{"enabled" = 0;"name" = "DIRECTORIES";}' \
# 	'{"enabled" = 1;"name" = "PDF";}' \
# 	'{"enabled" = 0;"name" = "FONTS";}' \
# 	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
# 	'{"enabled" = 0;"name" = "MESSAGES";}' \
# 	'{"enabled" = 0;"name" = "CONTACT";}' \
# 	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
# 	'{"enabled" = 0;"name" = "IMAGES";}' \
# 	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
# 	'{"enabled" = 0;"name" = "MUSIC";}' \
# 	'{"enabled" = 0;"name" = "MOVIES";}' \
# 	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
# 	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
# 	'{"enabled" = 0;"name" = "SOURCE";}'
# 	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
# 	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
# 	'{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
# 	'{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
# 	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
# 	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# permanent do not disturb for notification center
defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui \
  doNotDisturb -boolean true

defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui \
  doNotDisturbDate -date "$(date -u +"%Y-%m-%d %H:%M:%S +0000")"

# image id extracted from google drive download link
[ -e ~/wallpaper.jpg ] || wget -O ~/wallpaper.jpg "https://drive.google.com/uc?id=13NTYp1GfStf2jlM8EF3qtcBRFDyTbx_1"
osascript -e '
tell application "System Events"
  tell every desktop
    set picture to "~/wallpaper.jpg"
  end tell
end tell'

osascript -e '
tell application "System Preferences"
	activate
end tell

tell application "System Events"
	tell process "System Settings"
		click menu item "Keyboard" of menu "View" of menu bar 1
    log "Map caps to ctrl manually"
    -- TODO: find how to click into "Keyboard Shortcuts"
	end tell
end tell
'

# TODO: current manual steps
# remap caps lock to ctrl for internal/external keyboards
#   System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys

# disable cmd-space for spotlight
#   System Settings > Keyboard > Keyboard Shortcuts > Spotlight

# enable cmd-space for raycast/alfred

# Raycast Extensions
# set_display_mode
# set_audio_device
# kill_process
# sys_monitor
# chatgpt
# gemini
# color_picker
# clipboard_history
# speed_test
# rectange or Window Management
# spotify
# thesaurus

# Raycast Aliases
# ss - spotify search

# Needed Raycast Extensions
# Change Display Scale
# Better Wifi/VPN modes
# Airplay
# Bluetooth

# configure finder sidebar

# import terminal.app settings via applescript

# set accent color (apple notes link color) to blue

# force reload
killall Finder Dock NotificationCenter
