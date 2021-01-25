//
//  AppDelegate.h
//  ToggleStatusItemMenu
//
//  Created by William Gustafson on 1/25/21.
//

#import <Cocoa/Cocoa.h>
#import <MASShortcut/Shortcut.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>

@property (strong) NSStatusItem *statusItem;

@property (strong) IBOutlet NSMenu *statusMenu;
@property (nonatomic, assign) BOOL statusMenuOpen;

#define kShowMenuHotkey @"ShowMenuHotkey"
@property (strong) IBOutlet MASShortcutView *hotK_ShowMenu;



@end

