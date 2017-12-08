//
//  KeyRunLoop.h
//  KeyboardHooker
//
//  Created by Иван on 24.11.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

#import "KeyHooker.h"
#import "BlockKeyManager.h"

@interface KeyRunLoop : NSObject

{
    BlockKeyManager *keyBlocker;
    KeyHooker *keyHooker;
}

- (id)init: (KeyHooker*)keyHooker : (BlockKeyManager*)keyBlocker;
- (void)setRunLoop;

@end
