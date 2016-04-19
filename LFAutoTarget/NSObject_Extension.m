//
//  NSObject_Extension.m
//  LFAutoTarget
//
//  Created by linfeng on 16/4/7.
//  Copyright © 2016年 linfeng. All rights reserved.
//


#import "NSObject_Extension.h"
#import "LFAutoTarget.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    NSLog(@"LFAutoTarget Plugin loaded successfully");
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[LFAutoTarget alloc] initWithBundle:plugin];
        });
    }
}

@end
