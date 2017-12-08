//
//  AppHider.m
//  KeyboardHooker
//
//  Created by Иван on 03.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "AppHider.h"

@implementation AppHider

+ (void)hide {
    ProcessSerialNumber psn = { 0, kCurrentProcess };
    TransformProcessType(&psn, kProcessTransformToForegroundApplication);
}

+ (void)unhide {
    ProcessSerialNumber psn = { 0, kCurrentProcess };
    TransformProcessType(&psn, kProcessTransformToUIElementApplication);
}

@end
