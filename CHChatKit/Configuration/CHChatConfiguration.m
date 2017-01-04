//
//  CHChatConfiguration.m
//
//  Created by Chausson on 16/9/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatConfiguration.h"


@implementation CHChatConfiguration

+ (CHChatConfiguration *)defultConfigruration{
//    static dispatch_once_t onceToken;
//    static CHChatConfiguration *instance = nil;
//    dispatch_once(&onceToken, ^{
      CHChatConfiguration *instance = [CHChatConfiguration new];
        instance.mainBackground = [UIColor blackColor];
        instance.iconCornerRadius = 0;
        instance.allowEmoji = YES;
        instance.allowAssistance = YES;
        instance.allowRecordVoice = YES;
        instance.allowDeviceShock = YES;
        instance.allowDeviceTone = YES;
        instance.toolInputViewBackground = [UIColor clearColor];
        instance.toolContentBackground = [UIColor colorWithRed:241.0/ 255.0 green:241.0/255.0 blue:244.0 / 255.0 alpha:1];
//    });
    return instance;
}

- (void)addAssistance:(Class )aClass{
    @synchronized (self) {
        NSMutableArray *items = [NSMutableArray arrayWithArray:_assistances];
        
        [items addObject:aClass];
        
        _assistances = [items copy];
    }
}
- (void)addAssistances:(NSArray  <Class >*)aClasses{
        @synchronized (self) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:_assistances];
        [array addObjectsFromArray:aClasses];
        _assistances = [array copy];
    }
}
- (void)removeAssistanceItem:(Class )aClass{
    @synchronized (self) {
        NSMutableArray *items = [NSMutableArray arrayWithArray:_assistances];

        [items enumerateObjectsUsingBlock:^(Class class, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([NSStringFromClass(aClass) isEqualToString:NSStringFromClass(class)]) {
                [items removeObject:aClass];
                *stop = YES;
            }
        }];
        _assistances = [items copy];
    }
}

@end
