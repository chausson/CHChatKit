//
//  CHNoticeEventHandler.m
//  CHChatKit
//
//  Created by Chausson on 16/10/13.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "XEBEventBus.h"
#import "CHNoticeEvent.h"
#import "CHNoticeEventHandler.h"
@interface CHNoticeEventHandler()<XEBSubscriber> {
    id _retainedSelf;
}

@end


@implementation CHNoticeEventHandler

+ (NSArray<Class>*)handleableEventClasses {
    return @[ [CHNoticeEvent class] ];
}
- (void)registerHandler {
    assert(_retainedSelf == nil);
    
    _retainedSelf = self;
    
    XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
    [eventBus registerSubscriber: self];
}

- (void)unregisterHandler {
    assert(_retainedSelf != nil);
    
    XEBEventBus* eventBus = [XEBEventBus defaultEventBus];
    [eventBus unregisterSubscriber: self];
    
    _retainedSelf = nil;
}

#pragma XEBSubscriber

- (void)onEvent: (id)event {
    if([event isKindOfClass: [CHNoticeEvent class]]) {
        void (^handleBlock)(id event) = [self handleBlock];
        if(handleBlock != nil) {
            handleBlock(event);
        }
        
        [self unregisterHandler];
    }
}
@end
