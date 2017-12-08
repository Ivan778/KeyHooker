//
//  Cryptographer.m
//  KeyboardHooker
//
//  Created by Иван on 03.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "Cryptographer.h"

@implementation Cryptographer

+ (NSMutableString*)doIt: (NSString*)toEncrypt {
    char key[5] = {'A', 'B', 'C', 'D', 'E'};
    
    NSMutableString *output = [[NSMutableString alloc] init];
    for (int i = 0; i < toEncrypt.length; i++) {
        [output appendString:  [NSString stringWithFormat:@"%c", [toEncrypt characterAtIndex:i] ^ key[i % (sizeof(key) / sizeof(char))]]];
    }
    
    return output;
}

@end
