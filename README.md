# IFTTTunes
#### Cocoa application for sending iTunes track information to [IFTTT](https://ifttt.com)

## Installation
1. Enable the [Maker Channel](https://ifttt.com/maker) if you haven't already
2. Replace the value in Constants.h with your secret key
3. Build the app and place it somewhere on your computer, then set it as a hidden startup item
4. Create an IFTTT recipe using a Maker Channel trigger with the Event Name set as “itunes” 

## Usage
The app sends a pre-formatted string containing basic track information as **Value1** and a JSON-encoded equivalent as **Value2** to your Maker Channel.

## Tips
You might need to dump the interface for your iTunes install to be used with [Scripting Bridge](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ScriptingBridgeConcepts/Introduction/Introduction.html). Just replace iTunes.h with:

```shell
$ xcrun sdef /Applications/iTunes.app | xcrun sdp -fh --basename iTunes 
```

## @todo
- System Preferences bundle to store Maker Channel secret key and customizable track string format

© 2015 [Greg Rotter](http://www.ocf.berkeley.edu/~grotter/). Released under the [MIT License](http://www.opensource.org/licenses/mit-license.php).
