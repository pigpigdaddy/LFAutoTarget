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
    NSArray *originaArray = [targetString componentsSeparatedByString:@","];
    
    NSMutableString *pureTargets = [NSMutableString string];
    [originaArray enumerateObjectsUsingBlock:^(NSString *target, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *pureTarget = [self trimmingWhitespacePrefixSuffix:target];
        NSLog(@"pureTarget %@", pureTarget);
        if (idx < originaArray.count - 1) {
            [pureTargets appendFormat:@"%@,", pureTarget];
        }else{
            [pureTargets appendString:pureTarget];
        }
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:pureTargets forKey:kAutoTargets];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:[NSString stringWithFormat:@"Done ! \n %@", pureTargets]];
    [alert runModal];
}

- (NSString *)trimmingWhitespacePrefixSuffix:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
