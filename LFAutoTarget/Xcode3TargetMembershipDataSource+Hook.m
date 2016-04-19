//
//  Xcode3TargetMembershipDataSource+Hook.m
//  LFAutoTarget
//
//  Created by linfeng on 16/4/18.
//  Copyright © 2016年 linfeng. All rights reserved.
//

#import "Xcode3TargetMembershipDataSource+Hook.h"
#import "NSObject_Extension.h"

#define kTarget1 @"1"
#define kTarget2 @"2"
#define kTarget3 @"3"


@implementation Xcode3TargetMembershipDataSource (Hook)

+ (void)hook
{
    [self lf_swizzleInstanceSelector:@selector(updateTargets) withSelector:@selector(updateTargetsHook)];
}

- (void)updateTargetsHook
{
    // 先调用原来的方法
    [self updateTargetsHook];
    // 修改wrappedTarget的属性值
    NSMutableArray *wrappedTargets = [self valueForKey:@"wrappedTargets"];
    for (id wrappedTarget in wrappedTargets) {
        if ([[wrappedTarget valueForKey:@"name"] isEqualToString:kTarget1] || [[wrappedTarget valueForKey:@"name"] isEqualToString:kTarget2] || [[wrappedTarget valueForKey:@"name"] isEqualToString:kTarget3]) {
            [wrappedTarget setValue:@YES forKey:@"selected"];
        }
    }
}

@end
