//
//  NSObject+KVOExtension.h
//  CHChatKit
//
//  Created by Chausson on 16/9/21.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVOExtension)

- (void)registerForKVO;
- (void)unregisterFromKVO;
- (NSArray *)registerKeypaths;

@end
