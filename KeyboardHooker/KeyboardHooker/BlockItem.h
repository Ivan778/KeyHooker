//
//  BlockItem.h
//  KeyboardHooker
//
//  Created by Иван on 04.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockItem : NSObject


@property NSInteger key;
@property NSInteger delay;
@property NSInteger start;
@property NSMutableString *blockKeys;

- (id)init: (NSInteger)k : (NSInteger)d: (NSInteger)s;

@end
