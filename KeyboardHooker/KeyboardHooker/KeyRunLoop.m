//
//  KeyRunLoop.m
//  KeyboardHooker
//
//  Created by Иван on 24.11.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "KeyRunLoop.h"

@implementation KeyRunLoop


CGEventRef pressedSomeKeyDown(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    int key = (int)CGEventGetIntegerValueField(event, kCGKeyboardEventKeycode);
    if ([((__bridge KeyRunLoop*)refcon)->keyBlocker blockCycle:key]) {
        return nil;
    }
    
    [((__bridge KeyRunLoop*)refcon)->keyHooker doFullCycle:key];
    return event;
}

- (id)init: (KeyHooker*)keyH : (BlockKeyManager*)keyB {
    self = [super init];
    
    keyHooker = keyH;
    keyBlocker = keyB;
    
    return self;
}

- (void)setRunLoop {
    CFRunLoopSourceRef runLoopSource;
    
    CFMachPortRef eventTap = CGEventTapCreate(kCGHIDEventTap, kCGHeadInsertEventTap,
                                              kCGEventTapOptionDefault, CGEventMaskBit(kCGEventKeyDown) | CGEventMaskBit(kCGEventFlagsChanged),
                                              pressedSomeKeyDown, (__bridge void*)(self));
    
    if (!eventTap) NSLog(@"Couldn't create event tap!");
    
    runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
    CGEventTapEnable(eventTap, true);
}

@end
