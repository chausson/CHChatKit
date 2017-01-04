//
//  CHChatAssistanceItem.m
//  CHChatKit
//
//  Created by Chausson on 16/10/10.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHChatAssistance.h"
#import "CHMessageAssistanceEvent.h"

NSMutableDictionary <NSString *,Class>const* AssistanceDic = nil;

@implementation CHChatAssistance

+ (void)registerSubclass{
    if (!AssistanceDic) {
        AssistanceDic = [NSMutableDictionary dictionary];
    }
    if ([[self class] isSubclassOfClass:[CHChatAssistance class]]) {
        [AssistanceDic setObject:[self class] forKey:NSStringFromClass(self)];
    }
}
- (void)executeEvent:(id )responder{

}
- (void)postEvent{
    __weak typeof (self)weakSelf = self;
    CHMessageAssistanceEvent *event = [CHMessageAssistanceEvent new];
    event.item = weakSelf;
    [[XEBEventBus defaultEventBus] postEvent:event];

}
@end
