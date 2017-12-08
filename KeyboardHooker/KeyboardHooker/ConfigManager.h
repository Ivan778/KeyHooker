//
//  ConfigUpdate.h
//  KeyboardHooker
//
//  Created by Иван on 06.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FileManager.h"
#import "Cryptographer.h"
#import "RegexManager.h"

@interface ConfigManager : NSObject

+ (void)updateState: (NSInteger)state;
+ (void)updateConfig: (NSString*)email Size: (NSString*)size State: (NSInteger)state;
+ (NSInteger)getCurrentState;

@end
