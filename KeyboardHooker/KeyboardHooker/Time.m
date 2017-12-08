//
//  Time.m
//  KeyboardHooker
//
//  Created by Иван on 24.11.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "Time.h"

@implementation Time

+ (NSString*)currentTime {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    
    return [outputFormatter stringFromDate:[NSDate date]];
}

+ (NSString*)currentFullTime {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    
    return [outputFormatter stringFromDate:[NSDate date]];
}

+ (NSInteger)currentTimeSince1970InMilliseconds {
    NSTimeInterval milisecondedDate = ([[NSDate date] timeIntervalSince1970] * 1000);
    return round(milisecondedDate);
}

@end
