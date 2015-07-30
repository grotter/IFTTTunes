#!/bin/sh

cd /tmp

# download binaries to appropriate locations
curl -o /tmp/IFTTTunes.tar.gz https://raw.githubusercontent.com/grotter/IFTTTunes/master/deploy/IFTTTunes.tar.gz
tar xvzf /tmp/IFTTTunes.tar.gz
cp -R /tmp/IFTTTunesPrefs.prefPane ${HOME}/Library/PreferencePanes
cp -R /tmp/IFTTTunes.app /Applications

# set as hidden startup item
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/IFTTTunes.app", hidden:true}'

echo "IFTTTunes installed!"

# initial launch
open -j /Applications/IFTTTunes.app
open ${HOME}/Library/PreferencePanes/IFTTTunesPrefs.prefPane
