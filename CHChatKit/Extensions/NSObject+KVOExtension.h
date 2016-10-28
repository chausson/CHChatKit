//
//  NSObject+KVOExtension.h
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVOExtension)
@property (nonatomic, strong) NSArray<NSArray <NSString *>*>* observers;

- (void)ch_unregisterFromKVO;
- (void)ch_registerForKVO:(NSArray <NSString *>*)observers;
- (void)ch_ObserveValueForKey:(NSString *)key
                     ofObject:(id )obj
                       change:(NSDictionary *)change;
@end
