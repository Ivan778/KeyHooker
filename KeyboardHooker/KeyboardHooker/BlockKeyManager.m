//
//  BlockKeyManager.m
//  KeyboardHooker
//
//  Created by Иван on 05.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "BlockKeyManager.h"

@implementation BlockKeyManager

- (id)init: (NSMutableArray<BlockItem*>*)array : (id <BlockKeyManagerDelegate>)deleg {
    self = [super init];
    
    buttonsBlockArray = array;
    delegate = deleg;
    pressAddFlag = false;
    
    return self;
}

- (BOOL)blockCycle: (NSInteger)curKey {
    index = [self check:curKey];
    
    if ([Time currentTimeSince1970InMilliseconds] - start <= delay) {
        NSString *keyString = [KeycodeEncrypter keyStringFromKeyCode:curKey];
        if ([toBlock containsString:keyString]) {
            return YES;
        }
    }
    
    if (index != -1) {
        start = [Time currentTimeSince1970InMilliseconds];
        delay = buttonsBlockArray[index].delay;
        toBlock = buttonsBlockArray[index].blockKeys;
    }
    
    if (pressAddFlag == YES) {
        if (index == -1) {
            BlockItem *item = [[BlockItem alloc] init:curKey :0 :[Time currentTimeSince1970InMilliseconds]];
            [buttonsBlockArray addObject:item];
            [delegate reloadTable];
        }
        pressAddFlag = NO;
        [delegate unlockAddButton];
        
        return YES;
    }
    
    return NO;
}

- (int)check: (NSInteger)key {
    int i = 0;
    for (BlockItem *item in buttonsBlockArray) {
        if (item.key == key) {
            return i;
        }
        i++;
    }
    return -1;
}

- (void)setPressAddFlag: (BOOL)flag {
    pressAddFlag = flag;
}

@end
