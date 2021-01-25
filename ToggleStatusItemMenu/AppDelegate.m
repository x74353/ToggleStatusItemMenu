//
//  AppDelegate.m
//  ToggleStatusItemMenu
//
//  Created by William Gustafson on 1/25/21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.statusMenuOpen = NO;
    
    // CONFIGURE THE STATUS ITEM + MENU
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
    [self.statusItem.button sendActionOn: (NSEventMaskLeftMouseUp|NSEventMaskRightMouseUp)];
    [self.statusItem.button setAction: @selector(statusItemClicked:)];
    self.statusItem.button.title = @"HelloWorld";
    self.statusMenu.delegate = self;
    
    // CONFIGURE THE MASSHORTCUT/HOTKEY VIEW
    self.hotK_ShowMenu.associatedUserDefaultsKey = kShowMenuHotkey;
    
    [[MASShortcutBinder sharedBinder] bindShortcutWithDefaultsKey: kShowMenuHotkey toAction: ^
     {
        NSLog(@"Hotkey block called");
        
         if (!self.statusMenuOpen)
         {
             [self performSelector:@selector(showStatusMenu:) withObject:self afterDelay:0.01];
         }
         else
         {
             [self.statusMenu cancelTracking];
         }
     }];
}


- (IBAction) statusItemClicked: (id) sender
{
    [self performSelector:@selector(showStatusMenu:) withObject:self afterDelay:0.01];
}

- (IBAction) showStatusMenu: (id) sender
{
    self.statusItem.menu = self.statusMenu;
    [self.statusItem.button performClick:nil];
    
    // UNFORTUNATELY THE FOLLOWING WILL NOT CAUSE THE STATUS ITEM'S MENU TO APPEAR
//    [self.statusItem performSelector:@selector(button)
//                          withObject:nil
//                          afterDelay:0
//                             inModes:@[NSRunLoopCommonModes]];
}



- (void) menuWillOpen: (NSMenu *) menu
{
    self.statusMenuOpen = YES;
}

- (void) menuDidClose:(NSMenu *) menu
{
    // WHEN THE MENU CLOSES, RESET THE STATUS ITEM TO NOT HAVE A MENU
    // THIS IS NEEDED TO SUPPORT DIFFERNT LEFT/RIGHT CLICK ACTIONS
    self.statusItem.menu = nil;
    [self.statusItem.button setAction: @selector(statusItemClicked:)];
    self.statusMenuOpen = NO;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}


@end
