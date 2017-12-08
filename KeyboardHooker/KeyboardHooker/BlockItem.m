//
//  BlockItem.m
//  KeyboardHooker
//
//  Created by Иван on 04.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "BlockItem.h"

@implementation BlockItem

- (id)init: (NSInteger)k : (NSInteger)d: (NSInteger)s {
    self = [super init];
    
    self.key = k;
    self.delay = d;
    self.start = s;
    self.blockKeys = [NSMutableString stringWithFormat:@""];
    
    return self;
}

@end
