//
//  RegexManager.m
//  KeyboardHooker
//
//  Created by Иван on 03.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "RegexManager.h"

@implementation RegexManager

+ (BOOL)validateEmail: (NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)validateDigitsOnly: (NSString *)candidate {
    NSString *sizeRegex = @"\\d+";
    NSPredicate *sizeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", sizeRegex];
    return [sizeTest evaluateWithObject:candidate];
}

+ (BOOL)validateLowCaseOnly: (NSString*)candidate {
    NSString *sizeRegex = @"^[a-z0-9]+$";
    NSPredicate *sizeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", sizeRegex];
    
    return [sizeTest evaluateWithObject:candidate];
}

@end
