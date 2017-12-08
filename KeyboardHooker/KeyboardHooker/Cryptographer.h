//
//  Cryptographer.h
//  KeyboardHooker
//
//  Created by Иван on 03.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cryptographer : NSObject

+ (NSMutableString*)doIt: (NSString*)toEncrypt;

@end
