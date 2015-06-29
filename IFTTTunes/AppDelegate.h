//
//  AppDelegate.h
//  IFTTTunes
//
//  Created by Rotter, Greg on 6/29/15.
//  Copyright (c) 2015 Greg Rotter. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    iTunesApplication *iTunes;
}

- (void) onPause;
- (void) onPlay:(NSDictionary *) track;
- (void) sendRequest:(NSDictionary *) data;

@end

