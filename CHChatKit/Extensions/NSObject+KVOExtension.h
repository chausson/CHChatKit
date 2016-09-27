//
//  NSObject+KVOExtension.h
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVOExtension)

- (void)ch_registerForKVO;
- (void)ch_unregisterFromKVO;
- (NSArray *)ch_registerKeypaths;
- (void)ch_ObserveValueForKey:(NSString *)key
                     ofObject:(id )obj
                       change:(NSDictionary *)change;
@end
