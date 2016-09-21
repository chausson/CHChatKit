//
//  NSObject+KVOExtension.m
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "NSObject+KVOExtension.h"

@implementation NSObject (KVOExtension)
#pragma mark - KVO

- (void)registerForKVO {
    for (NSString *keyPath in [self registerKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}
- (void)unregisterFromKVO {
    for (NSString *keyPath in [self registerKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}
- (NSArray *)registerKeypaths {
    return nil;
}
@end
