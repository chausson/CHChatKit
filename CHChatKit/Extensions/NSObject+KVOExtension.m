//
//  NSObject+KVOExtension.m
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "NSObject+KVOExtension.h"
#import <objc/runtime.h>
static char AddressKey;

@implementation NSObject (KVOExtension)
#pragma mark - KVO


- (void)setObservers:(NSArray<NSArray<NSString *> *> *)observers{
    objc_setAssociatedObject(self, &AddressKey, observers, OBJC_ASSOCIATION_COPY_NONATOMIC);

}
- (NSArray<NSArray<NSString *> *> *)observers{

    return objc_getAssociatedObject(self, &AddressKey);

}
- (void)ch_registerForKVO:(NSArray <NSString *>*)observers{
    if (!observers) {
        return;
    }
    if (!self.observers) {
        self.observers = [NSArray array];
    }
    NSMutableArray *obsMutable = [NSMutableArray arrayWithArray:self.observers];
    @synchronized (self) {
        for (NSString *keyPath in observers) {
            [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
        }
        [obsMutable addObject:observers];
        self.observers = [obsMutable copy];
    }
    
}
- (void)ch_unregisterFromKVO {

    NSLog(@"%@ ch_unregister",self.observers);
    if (self.observers.count > 0) {
        @synchronized (self) {
            NSMutableArray *obsMutable = [NSMutableArray arrayWithArray:self.observers];
            [[obsMutable lastObject] enumerateObjectsUsingBlock:^(NSString *  keyPath, NSUInteger idx, BOOL *  stop) {
                [self removeObserver:self forKeyPath:keyPath context:NULL];
            }];
            [obsMutable removeLastObject];
            self.observers = [obsMutable copy];
        }
    }


}
- (void)ch_ObserveValueForKey:(NSString *)key
                     ofObject:(id )obj
                       change:(NSDictionary *)change{
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self ch_ObserveValueForKey:keyPath ofObject:object change:change];
}
@end
