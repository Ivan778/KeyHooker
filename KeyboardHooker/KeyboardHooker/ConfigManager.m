//
//  ConfigUpdate.m
//  KeyboardHooker
//
//  Created by Иван on 06.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "ConfigManager.h"

@implementation ConfigManager

+ (void)updateState: (NSInteger)state {
    NSString *stateString = [Cryptographer doIt:[NSString stringWithFormat:@"%ld", state]];
    NSString *content = [FileManager readFromFile:@"config"];
    
    NSArray *components = [content componentsSeparatedByString:@"\n"];
    if ([components count] == 3) {
        [FileManager clearFile:@"config"];
        [FileManager writeToFile:@"config" file:[NSString stringWithFormat:@"%@\n", components[0]]];
        [FileManager writeToFile:@"config" file:[NSString stringWithFormat:@"%@\n", components[1]]];
        [FileManager writeToFile:@"config" file:[NSString stringWithFormat:@"%@", stateString]];
    }
}

+ (void)updateConfig: (NSString*)email Size: (NSString*)size State: (NSInteger)state {
    [FileManager createFile:@"config"];
    
    if ([RegexManager validateEmail:email] && [RegexManager validateDigitsOnly:size]) {
        NSString *e = [Cryptographer doIt:email];
        NSString *s = [Cryptographer doIt:size];
        NSString *m = [Cryptographer doIt:[NSString stringWithFormat:@"%ld", state]];
        
        [FileManager writeToFile:@"config" file:[NSString stringWithFormat:@"%@\n", e]];
        [FileManager writeToFile:@"config" file:[NSString stringWithFormat:@"%@\n", s]];
        [FileManager writeToFile:@"config" file:[NSString stringWithFormat:@"%@", m]];
    }
}

+ (NSInteger)getCurrentState {
    NSString *content = [FileManager readFromFile:@"config"];
    
    NSArray *components = [content componentsSeparatedByString:@"\n"];
    if ([components count] == 3) {
        NSString *state = [Cryptographer doIt:components[2]];
        if ([state isEqualToString:@"0"] || [state isEqualToString:@"1"]) {
            return [state integerValue];
        }
    }
    return  -1;
}

@end
