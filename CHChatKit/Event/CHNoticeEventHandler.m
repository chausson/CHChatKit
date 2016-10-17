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
@property(nonatomic) XEBEventBus* eventBus;
@end


@implementation CHNoticeEventHandler
- (instancetype)init
{
    self = [super init];
    if (self) {
        _autoUnregisterHandler = YES;
    }
    return self;
}
+ (NSArray<Class>*)handleableEventClasses {
    return @[ [NSObject class] ];
}

- (XEBEventBus*)eventBus {
    return _eventBus ?: [XEBEventBus defaultEventBus];
}

- (Class)eventClass {
    return _eventClass ?: [NSObject class];
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
    Class eventClass = [self eventClass];
    if([event isKindOfClass: eventClass]) {
        void (^handleBlock)(id event) = [self handleBlock];
        if(handleBlock != nil) {
            handleBlock(event);
        }
        if (_autoUnregisterHandler) {
            [self unregisterHandler];
        }
 
    }
}
@end
