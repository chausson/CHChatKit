//
//  CHMessageEventCenter.m
//  CHChatKit
//
//  Created by Chausson on 16/9/29.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHMessageEventCenter.h"
#import "XEBEventBus.h"
#import "XEBSubscriber.h"
#import "CHMessageEvent.h"
#import "CHMessageTextEvent.h"
#import "CHMessagePictureEvent.h"
#import "CHMessageLocationEvent.h"
#import "CHMessageReceiveEvent.h"
#import "CHChatMessageVMFactory.h"
#import "CHMessageVoiceEvent.h"
#import <CoreLocation/CoreLocation.h>
@interface CHMessageEventCenter ()<XEBSubscriber>

@end
@implementation CHMessageEventCenter{
    XEBEventBus* _eventBus;
}
+ (void)load{
    [CHMessageEventCenter shareInstance] ->_eventBus = [XEBEventBus defaultEventBus];
    [[CHMessageEventCenter shareInstance] ->_eventBus registerSubscriber: [CHMessageEventCenter shareInstance]];
    
}
+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
- (void)onEvent: (CHMessageEvent *)event{
    if ([event isKindOfClass:[CHMessageTextEvent class]]) {
        [self executeTextEvent:(CHMessageTextEvent *)event];
        return;
    }else if ([event isKindOfClass:[CHMessagePictureEvent class]]){
        [self executePictureEvent:(CHMessagePictureEvent *)event];
        return;
    }else if ([event isKindOfClass:[CHMessageLocationEvent class]]){
        [self executeLocationEvent:(CHMessageLocationEvent *)event];
        return;
    }else if ([event isKindOfClass:[CHMessageVoiceEvent class]]){
        [self executeVoiceEvent:(CHMessageVoiceEvent *)event];
        return;
    }
}
- (void)executeTextEvent:(CHMessageTextEvent *)event{

    CHChatMessageViewModel *viewModel = [CHChatMessageVMFactory factoryTextOfUserIcon:nil timeData:event.date  nickName:nil content:event.text isOwner:YES];
    [self postReceiveEvent:viewModel];
}
- (void)executePictureEvent:(CHMessagePictureEvent *)event{
    CHChatMessageImageVM *viewModel = [CHChatMessageVMFactory factoryImageOfUserIcon:nil timeData:event.date nickName:nil resource:event.file thumbnailImage:nil fullImage:event.fullPicture size:0 width:0 height:0 isOwner:YES];
    [self postReceiveEvent:viewModel];
}
- (void)executeLocationEvent:(CHMessageLocationEvent *)event{
    CHChatMessageLocationVM *viewModel = [CHChatMessageVMFactory factoryLoactionOfUserIcon:nil timeDate:event.date nickName:nil areaName:event.title areaDetail:event.detail resource:event.file longitude:event.location.coordinate.longitude latitude:event.location.coordinate.latitude isOwner:YES];
    [self postReceiveEvent:viewModel];
}
- (void)executeVoiceEvent:(CHMessageVoiceEvent *)event{
    CHChatMessageVoiceVM *viewModel = [CHChatMessageVMFactory factoryVoiceOfUserIcon:nil timeData:event.date nickName:nil resource:event.file voiceLength:event.length isOwner:YES];
    [self postReceiveEvent:viewModel];
}
- (void)postReceiveEvent:(CHChatMessageViewModel *)viewModel{
    CHMessageReceiveEvent *r = [CHMessageReceiveEvent new];
    r.item = viewModel;
    [_eventBus postEvent:r];
}
- (void)dealloc {
    [_eventBus unregisterSubscriber: self];
}
+ (NSArray<Class>*)handleableEventClasses {
    return @[ [CHMessageTextEvent class],[CHMessagePictureEvent class],[CHMessageLocationEvent class] ,[CHMessageVoiceEvent class]];
}
@end
