//
//  AppDelegate.m
//  IFTTTunes
//
//  Created by Rotter, Greg on 6/29/15.
//  Copyright (c) 2015 Greg Rotter. All rights reserved.
//

#import "iTunes.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

// @see
// http://stackoverflow.com/questions/8088473/url-encode-a-nsstring

- (NSString *) jsonString:(NSDictionary *) data {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:(NSJSONWritingOptions) 0
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"jsonString: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

- (void) sendRequest:(NSDictionary *) data {
    NSMutableString *urlString = [[NSMutableString alloc] init];
    [urlString appendString:@"https://maker.ifttt.com/trigger/itunes/with/key/"];
    [urlString appendString:IFTTT_SECRET_KEY];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSMutableString *postString = [NSMutableString new];
    
    // track info
    NSString *track = [NSString stringWithFormat:@"%@ / \"%@\", %@ \(%@kbps)", [data objectForKey:@"artist"], [data objectForKey:@"name"], [data objectForKey:@"album"], [data objectForKey:@"bitRate"]];
    [postString appendFormat:(@"&%@=%@"), @"value1", track];
    
    // json
    NSString *json = [self jsonString:data];
    [postString appendFormat:(@"&%@=%@"), @"value2", json];
    
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void) onPause {
    NSLog(@"not playing");
    
//    [self sendRequest:[NSDictionary dictionaryWithObjectsAndKeys:
//                       @"1", @"paused",
//                       nil]];
}

- (void) onPlay:(NSDictionary *) trackInfo {
    NSLog(@"%@", trackInfo);
    [self sendRequest:trackInfo];
}

- (void) onEvent:(NSNotification *) notification {
    // setup iTunes reference
    iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    
    // do nothing if pausing / not playing
    if ([iTunes playerState] != iTunesEPlSPlaying) {
        [self onPause];
    } else {
        iTunesTrack *track = [iTunes currentTrack];
        
        NSString *bitRate = [[NSNumber numberWithInt:[track bitRate]] stringValue];
        
        NSDictionary *trackInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [track artist], @"artist",
                                   [track name], @"name",
                                   [track album], @"album",
                                   bitRate, @"bitRate",
                                   nil];
        
        [self onPlay:trackInfo];
    }
}

- (void) applicationDidFinishLaunching:(NSNotification *) aNotification {
    // setup listener
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc addObserver:self selector:@selector(onEvent:) name:@"com.apple.iTunes.playerInfo" object:nil];
    
    // auto-invoke listener on launch
    [self onEvent:nil];
}

- (void) applicationWillTerminate:(NSNotification *) notification {
    [self onPause];
    [[NSApplication sharedApplication] terminate:self];
}

@end
