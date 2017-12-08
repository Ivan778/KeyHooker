//
//  AppDelegate.m
//  KeyboardHooker
//
//  Created by Иван on 21.11.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSString *config = [FileManager readFromFile:@"config"];
    if ([config isNotEqualTo: @"error"]) {
        NSArray *components = [config componentsSeparatedByString:@"\n"];
        if ([components count] == 3) {
            if ([[Cryptographer doIt:components[2]] isEqualToString:@"1"]) {
                [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
            }
        }
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
}


@end
