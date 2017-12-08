//
//  RegexManager.h
//  KeyboardHooker
//
//  Created by Иван on 03.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexManager : NSObject

+ (BOOL)validateEmail: (NSString *)candidate;
+ (BOOL)validateDigitsOnly: (NSString *)candidate;
+ (BOOL)validateLowCaseOnly: (NSString*)candidate;

@end
