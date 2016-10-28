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


- (void)setObservers:(NSSet *)observers{
    objc_setAssociatedObject(self, &AddressKey, observers, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSSet *)observers{
    return objc_getAssociatedObject(self, &AddressKey);
}

- (void)ch_registerForKVO:(NSArray *)observers {
    if (!observers) {
        return;
    }
    
    NSLog(@"class= %@",NSStringFromClass(self.class));
    @synchronized (self) {

        NSMutableSet *registerObservers = [NSMutableSet setWithSet:self.observers];
        [registerObservers addObjectsFromArray:observers];
        
        for (NSString *keyPath in registerObservers) {
            [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
        }
        self.observers = registerObservers;
    }
    
            

}
- (void)ch_unregisterFromKVO {
    NSMutableSet *registerObservers = [self.observers mutableCopy];
    NSLog(@"%@",registerObservers);
    if (!registerObservers) {
        return;
    }
    @synchronized (self) {
        [registerObservers enumerateObjectsUsingBlock:^(NSString *keyPath, BOOL * _Nonnull stop) {
            [self removeObserver:self forKeyPath:keyPath context:NULL];
            [registerObservers removeObject:keyPath];
        }];
        self.observers = [NSSet setWithSet:registerObservers];
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
