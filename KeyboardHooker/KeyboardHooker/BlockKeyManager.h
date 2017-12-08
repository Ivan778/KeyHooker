//
//  BlockKeyManager.h
//  KeyboardHooker
//
//  Created by Иван on 05.12.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BlockItem.h"
#import "Time.h"
#import "KeycodeEncrypter.h"

@protocol BlockKeyManagerDelegate <NSObject>
@optional

- (void)reloadTable;
- (void)unlockAddButton;

@end

@interface BlockKeyManager : NSObject

{
    BOOL pressAddFlag;
    
    NSInteger currentKey;
    NSInteger index;
    NSInteger start;
    NSInteger delay;
    
    NSString *toBlock;
    NSMutableArray<BlockItem*> *buttonsBlockArray;
    
    id <BlockKeyManagerDelegate> delegate;
}

- (id)init: (NSMutableArray<BlockItem*>*)array : (id <BlockKeyManagerDelegate>)deleg;
- (BOOL)blockCycle: (NSInteger)curKey;
- (void)setPressAddFlag: (BOOL)flag;

@end
