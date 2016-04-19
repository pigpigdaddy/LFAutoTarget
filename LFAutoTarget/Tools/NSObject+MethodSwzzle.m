//
//  NSObject+MethodSwzzle.m
//  LFAutoTarget
//
//  Created by linfeng on 16/4/19.
//  Copyright © 2016年 linfeng. All rights reserved.
//

#import "NSObject+MethodSwzzle.h"
#import <objc/runtime.h>

@implementation NSObject (MethodSwzzle)

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
