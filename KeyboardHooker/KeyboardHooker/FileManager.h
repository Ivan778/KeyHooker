//
//  FileManager.h
//  KeyboardHooker
//
//  Created by Иван on 01.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (void)createFile: (NSString*)name;
+ (void)writeToFile: (NSString*)name file:(NSString*)stringToWrite;
+ (void)clearFile: (NSString*)name;
+ (unsigned long long)getFileSize: (NSString*)name;
+ (NSString*)pathToFile;
+ (NSString*)readFromFile: (NSString*)name;

@end
