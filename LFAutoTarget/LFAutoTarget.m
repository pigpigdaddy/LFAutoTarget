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

@interface LFAutoTarget()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, copy) NSString *selectedText;

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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(viewDidUpdateTrackingAreas:)
                                                     name:NSViewDidUpdateTrackingAreasNotification
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
    // 监听NSTextView的变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectionDidChange:)
                                                 name:NSTextViewDidChangeSelectionNotification
                                               object:nil];
    // 获取 Edit
    NSMenuItem *editMenuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (editMenuItem) {
        // 加一个分隔线
        [[editMenuItem submenu] addItem:[NSMenuItem separatorItem]];
        // 加一个menu
        NSMenuItem *newMenuItem = [[NSMenuItem alloc] initWithTitle:@"What is selected" action:@selector(showSelected:) keyEquivalent:@""];
        [newMenuItem setTarget:self];
        [newMenuItem setKeyEquivalentModifierMask: NSAlternateKeyMask];
        [[editMenuItem submenu] addItem:newMenuItem];   
    }
}

- (void)selectionDidChange:(NSNotification *)notification
{
    if ([[notification object] isKindOfClass:[NSTextView class]]) {
        NSTextView* textView = (NSTextView *)[notification object];
        
        NSArray* selectedRanges = [textView selectedRanges];
        if (selectedRanges.count==0) {
            return;
        }
        
        NSRange selectedRange = [[selectedRanges objectAtIndex:0] rangeValue];
        NSString* text = textView.textStorage.string;
        self.selectedText = [text substringWithRange:selectedRange];
        NSLog(@"selectionDidChange %@", self.selectedText);
    }
}

- (void)showSelected:(NSNotification *)notification
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText: self.selectedText];
    [alert runModal];
}

- (void)viewDidUpdateTrackingAreas:(NSNotification *)notification
{
    //打印出视图对象以及视图的大小
    NSView *view = notification.object;
    if ([view respondsToSelector:@selector(frame)]) {
        if ([view isKindOfClass:[NSTableView class]]) {
            NSTableView *tableView = (NSTableView *)view;
            NSLog(@"NSTableView dataSource : %@", tableView.dataSource);
            
        }
    }
}

@end
