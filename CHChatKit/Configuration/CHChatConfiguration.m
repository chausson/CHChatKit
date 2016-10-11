//
//  CHChatConfiguration.m
//
//  Created by Chausson on 16/9/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatConfiguration.h"


@implementation CHChatConfiguration

+ (CHChatConfiguration *)defultConfigruration{
    CHChatConfiguration *instance = [CHChatConfiguration new];
    instance = [CHChatConfiguration new];
    instance.mainBackground = [UIColor blackColor];
    instance.iconCornerRadius = 0;
    instance.allowEmoji = YES;
    instance.allowAssistance = YES;
    instance.allowRecordVoice = YES;
    instance.toolInputViewBackground = [UIColor clearColor];
    instance.toolContentBackground = [UIColor colorWithRed:241.0/ 255.0 green:241.0/255.0 blue:244.0 / 255.0 alpha:1];
    return instance;
}

- (void)addAssistance:(NSString *)identifier{
    @synchronized (self) {
        NSMutableArray *items = [NSMutableArray arrayWithArray:_assistances];
        
        [items addObject:identifier];
        
        _assistances = [items copy];
    }
}
- (void)addAssistances:(NSArray  <NSString *>*)identifiers{
    @synchronized (self) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:_assistances];
        [identifiers enumerateObjectsUsingBlock:^(NSString *identifier, NSUInteger idx, BOOL *  stop) {
            [array addObject:identifier];
        }];
        _assistances = [array copy];
    }
}
- (void)removeAssistanceItem:(NSString *)identifier{
    @synchronized (self) {
        NSMutableArray *items = [NSMutableArray arrayWithArray:_assistances];
        [items enumerateObjectsUsingBlock:^(NSString * _Nonnull assistanceIdentifier, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([assistanceIdentifier isEqualToString:identifier]) {
                [items removeObject:assistanceIdentifier];
                *stop = YES;
            }
        }];
        _assistances = [items copy];
    }
}

@end
