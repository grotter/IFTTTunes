#!/bin/sh

# remove startup item
osascript -e 'tell application "System Events" to delete login item "IFTTTunes"'

# kill if running
pkill IFTTTunes

# remove application and preference pane
rm -R ${HOME}/Library/PreferencePanes/IFTTTunesPrefs.prefPane
rm -R /Applications/IFTTTunes.app

echo "IFTTTunes successfully uninstalled."
