//
//  Xcode3TargetMembershipDataSource+Hook.m
//  LFAutoTarget
//
//  Created by linfeng on 16/4/18.
//  Copyright © 2016年 linfeng. All rights reserved.
//

#import "Xcode3TargetMembershipDataSource+Hook.h"
#import "NSObject+MethodSwzzle.h"
#import "LFAutoTarget.h"

@implementation Xcode3TargetMembershipDataSource (Hook)

+ (void)hook
{
    [self lf_swizzleInstanceSelector:@selector(updateTargets) withSelector:@selector(updateTargetsHook)];
}

- (void)updateTargetsHook
{
    // 先调用原来的方法
    [self updateTargetsHook];
    
    id targetsString = [[NSUserDefaults standardUserDefaults] objectForKey:@"kAutoTargets"];
    if ([targetsString isKindOfClass:[NSString class]]) {
        NSString *targets = targetsString;
        NSArray *targetsArray = [targets componentsSeparatedByString:@","];
        // 修改wrappedTarget的属性值
        NSMutableArray *wrappedTargets = [self valueForKey:@"wrappedTargets"];
        [wrappedTargets enumerateObjectsUsingBlock:^(id  _Nonnull wrappedTarget, NSUInteger idx, BOOL * _Nonnull stop) {
            [targetsArray enumerateObjectsUsingBlock:^(NSString *target, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([target isEqualToString:[wrappedTarget valueForKey:@"name"]]) {
                    [wrappedTarget setValue:@YES forKey:@"selected"];
                    return ;
                }
            }];
        }];
    }
}

@end
