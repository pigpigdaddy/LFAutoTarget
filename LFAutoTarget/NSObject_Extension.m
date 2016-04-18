//
//  NSObject_Extension.m
//  LFAutoTarget
//
//  Created by linfeng on 16/4/7.
//  Copyright © 2016年 linfeng. All rights reserved.
//


#import "NSObject_Extension.h"
#import "LFAutoTarget.h"
#import <objc/runtime.h>

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[LFAutoTarget alloc] initWithBundle:plugin];
        });
    }
}

+ (void)lf_swizzleInstanceSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector
{
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod)
    {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
