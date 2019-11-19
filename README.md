# IFTTTunes
#### Cocoa application for sending iTunes track information to [IFTTT](https://ifttt.com)

## Install
- Enable the [Maker Channel](https://ifttt.com/maker) if you haven't already.
- Install the application and preference pane by pasting the following command into the OS X Terminal utility (located in /Applications/Utilities/):

```shell
curl -fsSL https://raw.github.com/grotter/IFTTTunes/master/deploy/install.sh | sh
```

## Usage
Fill out your Maker Channel [secret key](https://ifttt.com/maker) in System Preferences. The app sends a pre-formatted string containing basic track information as **Value1** and the JSON-encoded equivalent as **Value2** to Maker Channel recipes with the *Event Name* trigger set as “itunes”.

E.g., follow [@rotterworld](https://twitter.com/rotterworld) to keep tabs on my questionable taste-levels in music. The @rotterworld Twitterbot uses IFTTTunes and this [recipe](https://ifttt.com/recipes/312285).

Set the application’s active state by toggling the little IFTTT button in the OS X menubar.

## Tips
This application has been tested with iTunes v11 and v12 and Music v1. You might need to dump the interface for your Music install to be used with [Scripting Bridge](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ScriptingBridgeConcepts/Introduction/Introduction.html) and recompile. Just replace Music.h with:

```shell
# legacy
# xcrun sdef /Applications/iTunes.app | xcrun sdp -fh --basename iTunes

xcrun sdef /System/Applications/Music.app | xcrun sdp -fh --basename Music
```

## Uninstall
Run the uninstall script via
```shell
curl -fsSL https://raw.github.com/grotter/IFTTTunes/master/deploy/uninstall.sh | sh
```

## @todo
- Add customizable track string format to preferences for **Value1**
