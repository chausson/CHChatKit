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

- (void)ch_registerForKVO {
    for (NSString *keyPath in [self ch_registerKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}
- (void)ch_unregisterFromKVO {
    for (NSString *keyPath in [self ch_registerKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}
- (NSArray *)ch_registerKeypaths {
    return nil;
}
- (void)ch_ObserveValueForKey:(NSString *)key
                     ofObject:(id )obj
                       change:(NSDictionary *)change{
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self ch_ObserveValueForKey:keyPath ofObject:object change:change];
}
@end
