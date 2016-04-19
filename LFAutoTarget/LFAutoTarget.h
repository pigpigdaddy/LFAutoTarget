//
//  LFAutoTarget.h
//  LFAutoTarget
//
//  Created by linfeng on 16/4/7.
//  Copyright © 2016年 linfeng. All rights reserved.
//

#import <AppKit/AppKit.h>

@class LFAutoTarget;

static LFAutoTarget *sharedPlugin;

@interface LFAutoTarget : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;

@end