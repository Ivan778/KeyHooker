//
//  FileManager.m
//  KeyboardHooker
//
//  Created by Иван on 01.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (NSString*)pathToDesktop {
    return [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString*)pathToFile {
    return [NSString stringWithFormat:@"%@/Documents/", [[[NSProcessInfo processInfo] environment] objectForKey:@"HOME"]];
}

+ (void)createFile: (NSString*)name {
    NSString *path = [NSString stringWithFormat:@"%@%@", [self pathToFile], name];
    [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
}

+ (void)writeToFile: (NSString*)name file:(NSString*)stringToWrite {
    NSString *path = [NSString stringWithFormat:@"%@%@", [self pathToFile], name];
    
    NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath: path];
    [myHandle seekToEndOfFile];
    [myHandle writeData:[stringToWrite dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (void)clearFile: (NSString*)name {
    NSString *path = [NSString stringWithFormat:@"%@%@", [self pathToFile], name];
    [@"" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (unsigned long long)getFileSize: (NSString*)name {
    NSString *path = [NSString stringWithFormat:@"%@%@", [self pathToFile], name];
    return [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
}

+ (NSString*)readFromFile: (NSString*)name {
    NSString *path = [NSString stringWithFormat:@"%@%@", [self pathToFile], name];
    NSError *error;
    NSString *returnValue = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    if (error == nil) {
        return returnValue;
    } else {
        return @"error";
    }
}

@end
