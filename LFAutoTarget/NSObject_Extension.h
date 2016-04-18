//
//  NSObject_Extension.h
//  LFAutoTarget
//
//  Created by linfeng on 16/4/7.
//  Copyright © 2016年 linfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin;

/**
 *  替换方法
 *
 *  @param originalSelector 原方法
 *  @param swizzledSelector 新方法
 */
+ (void)lf_swizzleInstanceSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;


@end
