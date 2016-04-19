//
//  LFAutoTarget.m
//  LFAutoTarget
//
//  Created by linfeng on 16/4/7.
//  Copyright © 2016年 linfeng. All rights reserved.
//

//16/4/18 下午4:41:25.493 Xcode[24368]: ******view : <NSTableView: 0x7fc9585b1b50>, frame : NSRect: {{0, 0}, {319, 212}}


#import "LFAutoTarget.h"
#import "NSView+Dumping.h"
#import "Xcode3TargetMembershipDataSource+Hook.h"

@interface LFAutoTarget()

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@end

@implementation LFAutoTarget

#pragma mark - life cycle
+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [Xcode3TargetMembershipDataSource hook];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 通知及UI响应
- (void)applicationDidFinishLaunching:(NSNotification*)notification
{
    // 获取 Edit
    NSMenuItem *pluginsMenuItem = [[NSApp mainMenu] itemWithTitle:@"Plugins"];
    if (pluginsMenuItem) {
        // 加一个分隔线
        [[pluginsMenuItem submenu] addItem:[NSMenuItem separatorItem]];
        // 加一个menu
        NSMenuItem *newMenuItem = [[NSMenuItem alloc] initWithTitle:@"Enabel AutoTarget" action:@selector(changeEnabelState:) keyEquivalent:@""];
        [newMenuItem setTarget:self];
        [newMenuItem setKeyEquivalentModifierMask: NSAlternateKeyMask];
        [[pluginsMenuItem submenu] addItem:newMenuItem];
    }
}

- (void)changeEnabelState:(NSNotification *)notification
{
    
}

@end
