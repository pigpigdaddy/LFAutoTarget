//
//  NSObject+MethodSwzzle.h
//  LFAutoTarget
//
//  Created by linfeng on 16/4/19.
//  Copyright © 2016年 linfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodSwzzle)

/**
 *  替换方法
 *
 *  @param originalSelector 原方法
 *  @param swizzledSelector 新方法
 */
+ (void)lf_swizzleInstanceSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;

@end
