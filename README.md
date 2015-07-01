# IFTTTunes
#### Cocoa application for sending iTunes track information to [IFTTT](https://ifttt.com)

## Installation
1. Enable the [Maker Channel](https://ifttt.com/maker) if you haven't already
2. Place the preference pane and application files in their proper locations via

```shell
$ mv IFTTTunesPrefs.prefPane ~/Library/PreferencePanes
$ mv IFTTTunes.app /Applications
```

3. Set the app as a hidden startup item

## Usage
Fill out your Maker Channel [secret key](https://ifttt.com/maker) in System Preferences. The app sends a pre-formatted string containing basic track information as **Value1** and the JSON-encoded equivalent as **Value2** to Maker Channel recipes with the *Event Name* trigger set as “itunes”.

## Tips
You might need to dump the interface for your iTunes install to be used with [Scripting Bridge](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ScriptingBridgeConcepts/Introduction/Introduction.html). Just replace iTunes.h with:

```shell
$ xcrun sdef /Applications/iTunes.app | xcrun sdp -fh --basename iTunes 
```

## @todo
- System Preferences bundle to store Maker Channel secret key and customizable track string format

© 2015 [Greg Rotter](http://www.ocf.berkeley.edu/~grotter/). Released under the [MIT License](http://www.opensource.org/licenses/mit-license.php).
