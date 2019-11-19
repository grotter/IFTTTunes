//
//  AppDelegate.m
//  IFTTTunes
//
//  Created by Rotter, Greg on 6/29/15.
//  Copyright (c) 2015 Greg Rotter. All rights reserved.
//

#import "Music.h"
#import "AppDelegate.h"
#import "IFTTTunes-Swift.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

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
    // get secret key from system prefs
    NSDictionary *prefs = [[NSUserDefaults standardUserDefaults]
                           persistentDomainForName:[[NSBundle bundleForClass:[self class]]
                                                  bundleIdentifier]];
    
    NSString *secretKey = [prefs objectForKey:@"secretKey"];
    
    if (!secretKey) return;
    
    // construct endpoint
    NSMutableString *urlString = [[NSMutableString alloc] init];
    [urlString appendString:@"https://maker.ifttt.com/trigger/itunes/with/key/"];
    [urlString appendString:secretKey];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSMutableString *postString = [NSMutableString new];
    
    // track info
    NSString *track = [NSString stringWithFormat:@"%@ / \"%@\", %@ \(%@kbps)", [data objectForKey:@"artist"], [data objectForKey:@"name"], [data objectForKey:@"album"], [data objectForKey:@"bitRate"]];
    [postString appendFormat:(@"&%@=%@"), @"value1", [self encodeURIComponent:track]];
    
    // json
    NSString *json = [self jsonString:data];
    [postString appendFormat:(@"&%@=%@"), @"value2", [self encodeURIComponent:json]];
    
    NSLog(@"postString: %@", postString);
    
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (NSString *) encodeURIComponent:(NSString *) input {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                               NULL,
                                                               (CFStringRef)input,
                                                               NULL,
                                                               (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                               kCFStringEncodingUTF8);
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
    // setup Music reference
    Music = [SBApplication applicationWithBundleIdentifier:@"com.apple.Music"];
    
    // do nothing if pausing / not playing / disabled
    if ([Music playerState] != MusicEPlSPlaying || !menuButton.sendToIFTTT) {
        [self onPause];
    } else {
        MusicTrack *track = [Music currentTrack];
        
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
    // menu button
    menuButton = [[MenuButton alloc] init];
    
    // setup listener
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc addObserver:self selector:@selector(onEvent:) name:@"com.apple.Music.playerInfo" object:nil];
    
    // auto-invoke listener on launch
    [self onEvent:nil];
}

- (void) applicationWillTerminate:(NSNotification *) notification {
    [self onPause];
    [[NSApplication sharedApplication] terminate:self];
}

@end
