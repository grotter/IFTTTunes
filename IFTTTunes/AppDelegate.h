//
//  AppDelegate.h
//  IFTTTunes
//
//  Created by Rotter, Greg on 6/29/15.
//  Copyright (c) 2015 Greg Rotter. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <IFTTTunes-Swift.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    MusicApplication *Music;
    MenuButton *menuButton;
}

- (void) onPause;
- (void) onPlay:(NSDictionary *) track;
- (void) sendRequest:(NSDictionary *) data;

@end

