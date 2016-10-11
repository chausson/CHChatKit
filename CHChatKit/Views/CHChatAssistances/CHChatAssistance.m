//
//  CHChatAssistanceItem.m
//  CHChatKit
//
//  Created by Chausson on 16/10/10.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatAssistance.h"


NSMutableDictionary <NSString *,Class>const* AssistanceDic = nil;

@implementation CHChatAssistance

+ (NSString *)registerAssistance{
    return nil;
}
+ (void)registerSubclass{
    if (!AssistanceDic) {
        AssistanceDic = [NSMutableDictionary dictionary];
    }
    if ([self conformsToProtocol:@protocol(CHChatAssistanceProtocol)] && [self registerAssistance]) {
        [AssistanceDic setObject:[self class] forKey:[self registerAssistance]];
    }
}
- (void)executeEvent:(id )responder{
    
}
@end
