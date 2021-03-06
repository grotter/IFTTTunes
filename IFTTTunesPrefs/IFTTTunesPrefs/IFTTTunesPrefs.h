//
//  IFTTTunesPrefs.h
//  IFTTTunesPrefs
//
//  Created by Rotter, Greg on 7/1/15.
//  Copyright (c) 2015 Greg Rotter. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>

@interface IFTTTunesPrefs : NSPreferencePane {
    IBOutlet NSTextField *secretKey;
    IBOutlet NSButton *visitIFTTT;
}

- (void) mainViewDidLoad;
- (void) saveChanges:(NSNotification*) aNotification;
- (IBAction) goToIFTTT:(id) sender;

@end

