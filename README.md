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

## Tips
This application has been tested with v11 and v12 of iTunes. You might need to dump the interface for your iTunes install to be used with [Scripting Bridge](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ScriptingBridgeConcepts/Introduction/Introduction.html) and recompile. Just replace iTunes.h with:

```shell
xcrun sdef /Applications/iTunes.app | xcrun sdp -fh --basename iTunes 
```

## Uninstall
Run the uninstall script via
```shell
curl -fsSL https://raw.github.com/grotter/IFTTTunes/master/deploy/uninstall.sh | sh
```

## @todo
- Add customizable track string format to preferences for **Value1**

© 2015 [Greg Rotter](http://www.ocf.berkeley.edu/~grotter/). Released under the [MIT License](http://www.opensource.org/licenses/mit-license.php).
