//
//  IFTTTunesPrefs.m
//  IFTTTunesPrefs
//
//  Created by Rotter, Greg on 7/1/15.
//  Copyright (c) 2015 Greg Rotter. All rights reserved.
//

#import "IFTTTunesPrefs.h"

@implementation IFTTTunesPrefs

- (void) mainViewDidLoad {
    NSDictionary *prefs=[[NSUserDefaults standardUserDefaults]
                         persistentDomainForName:[[NSBundle bundleForClass:[self class]]
                                                  bundleIdentifier]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveChanges:)
                                                 name:NSApplicationWillTerminateNotification
                                               object:nil];
    
    if (prefs) {
        [secretKey setStringValue:[prefs objectForKey:@"secretKey"]];
    }
}

- (void) saveChanges:(NSNotification*) aNotification {
    NSDictionary *prefs;
    
    prefs=[[NSDictionary alloc] initWithObjectsAndKeys:
           [secretKey stringValue], @"secretKey",
           nil];
    
    [[NSUserDefaults standardUserDefaults]
     removePersistentDomainForName:[[NSBundle bundleForClass:
                                     [self class]] bundleIdentifier]];
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:prefs
                                                       forName:[[NSBundle bundleForClass:[self class]] bundleIdentifier]];
}

- (IBAction) goToIFTTT:(id) sender {
    [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:@"https://ifttt.com/maker"]];
}

@end
