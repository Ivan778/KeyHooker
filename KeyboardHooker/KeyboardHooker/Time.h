//
//  Time.h
//  KeyboardHooker
//
//  Created by Иван on 24.11.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject

+ (NSString*)currentTime;
+ (NSString*)currentFullTime;
+ (NSInteger)currentTimeSince1970InMilliseconds;

@end
