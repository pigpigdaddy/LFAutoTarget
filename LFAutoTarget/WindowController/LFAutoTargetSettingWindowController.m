//
//  LFAutoTargetSettingWindowController.m
//  LFAutoTarget
//
//  Created by linfeng on 16/4/19.
//  Copyright © 2016年 linfeng. All rights reserved.
//

#import "LFAutoTargetSettingWindowController.h"

@interface LFAutoTargetSettingWindowController ()

@property (weak)IBOutlet NSButton *btnConfirm;
@property (weak)IBOutlet NSTextField *tfTargets;

@end

@implementation LFAutoTargetSettingWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    id targetsString = [[NSUserDefaults standardUserDefaults] objectForKey:kAutoTargets];
    if ([targetsString isKindOfClass:[NSString class]]) {
        [self.tfTargets setStringValue:(NSString *)targetsString];
    }
}

- (IBAction)confirmButtonAction:(NSButton *)sender {
    // 保存
    NSString *targetString = self.tfTargets.stringValue;
    [[NSUserDefaults standardUserDefaults] setObject:targetString forKey:kAutoTargets];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
